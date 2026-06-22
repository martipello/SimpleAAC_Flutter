// Upload core vocabulary to Firestore.
//
// Setup (one-time):
//   npm install firebase-admin
//
// Download your service account key:
//   Firebase Console → Project Settings → Service Accounts → Generate New Private Key
//   Save as serviceAccountKey.json in the project root.
//
// Usage:
//   node upload_vocabulary_to_firestore.js              # differential: skips unchanged words
//   node upload_vocabulary_to_firestore.js --force      # always overwrites every word
//   node upload_vocabulary_to_firestore.js --dry-run    # prints what would be written, no writes
//
// Firestore path written:
//   /vocabulary/{languageId}/words/{wordId}   ← one doc per word
//   /vocabulary/{languageId}                  ← metadata doc (wordCount, uploadedAt, scriptVersion)

'use strict';

const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore, FieldValue } = require('firebase-admin/firestore');
const fs = require('fs');
const path = require('path');

// ── Configuration ─────────────────────────────────────────────────────────────

const SERVICE_ACCOUNT_PATH = path.join(__dirname, 'serviceAccountKey.json');
const VOCABULARY_JSON_PATH = path.join(__dirname, 'assets', 'json', 'initial_word_data.json');

// Bump this whenever the schema or word data changes. The script compares
// this against the version stored in Firestore and skips uploading if they match
// (unless --force is passed).
const SCRIPT_VERSION = '1.0.0';

const FIRESTORE_BATCH_SIZE = 400; // Firestore max is 500; stay under to be safe
const CONCURRENCY = 3;            // parallel language uploads

// ── Parse flags ───────────────────────────────────────────────────────────────

const args = process.argv.slice(2);
const FORCE = args.includes('--force');
const DRY_RUN = args.includes('--dry-run');

if (DRY_RUN) console.log('🔍 DRY RUN — no writes will be made.\n');
if (FORCE)   console.log('⚡ FORCE mode — overwriting all words regardless of version.\n');

// ── Firebase init ─────────────────────────────────────────────────────────────

if (!fs.existsSync(SERVICE_ACCOUNT_PATH)) {
  console.error(`❌ serviceAccountKey.json not found at ${SERVICE_ACCOUNT_PATH}`);
  console.error('   Download it from Firebase Console → Project Settings → Service Accounts.');
  process.exit(1);
}

const serviceAccount = require(SERVICE_ACCOUNT_PATH);
initializeApp({ credential: cert(serviceAccount) });
const db = getFirestore();

// ── Helpers ───────────────────────────────────────────────────────────────────

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

/**
 * Commits an array of Firestore write operations in batches of FIRESTORE_BATCH_SIZE.
 * Each operation is { ref, data } where ref is a DocumentReference.
 */
async function commitInBatches(operations) {
  let committed = 0;
  for (let i = 0; i < operations.length; i += FIRESTORE_BATCH_SIZE) {
    const chunk = operations.slice(i, i + FIRESTORE_BATCH_SIZE);
    const batch = db.batch();
    for (const { ref, data } of chunk) {
      batch.set(ref, data);
    }
    if (!DRY_RUN) await batch.commit();
    committed += chunk.length;
    process.stdout.write(`  Committed ${committed} / ${operations.length} docs\r`);
  }
  process.stdout.write('\n');
}

/**
 * Strips fields that should never be stored in core vocabulary —
 * anything that is per-user state.
 */
function toCoreWordDoc(word) {
  return {
    wordId:              word.wordId,
    text:                word.text,
    phoneticOverride:    word.phoneticOverride ?? null,
    type:                word.type,
    subType:             word.subType,
    imagePath:           word.imagePath ?? null,
    isCoreVocabulary:    true,
    extraRelatedWordIds: word.extraRelatedWordIds ?? [],
    aiSuggestedFollowUps: word.aiSuggestedFollowUps ?? [],
    // createdDate set server-side on first write; never overwrite it.
  };
}

// ── Per-language upload ───────────────────────────────────────────────────────

async function uploadLanguage(language) {
  const langId = language.id;
  const words  = language.words ?? [];

  console.log(`\n── Language: ${language.displayName} (${langId}) — ${words.length} words`);

  const langRef  = db.collection('vocabulary').doc(langId);
  const wordsRef = langRef.collection('words');

  // Check stored version unless --force
  if (!FORCE) {
    const meta = await langRef.get();
    if (meta.exists) {
      const stored = meta.data();
      if (stored.scriptVersion === SCRIPT_VERSION && stored.wordCount === words.length) {
        console.log(`  ✅ Already up-to-date (version ${SCRIPT_VERSION}, ${words.length} words). Skipping.`);
        console.log('     Pass --force to overwrite anyway.');
        return;
      }
      console.log(`  ↻ Version mismatch: stored=${stored.scriptVersion ?? 'none'}, current=${SCRIPT_VERSION}. Re-uploading.`);
    } else {
      console.log(`  ✨ First upload for language "${langId}".`);
    }
  }

  // Build word write operations
  const wordOps = words.map((word) => ({
    ref:  wordsRef.doc(word.wordId),
    data: toCoreWordDoc(word),
  }));

  console.log(`  Writing ${wordOps.length} words in batches of ${FIRESTORE_BATCH_SIZE}...`);
  await commitInBatches(wordOps);

  // Write metadata doc last so version only advances after all words are written
  const metaData = {
    languageId:    langId,
    displayName:   language.displayName,
    wordCount:     words.length,
    scriptVersion: SCRIPT_VERSION,
    uploadedAt:    FieldValue.serverTimestamp(),
  };

  if (!DRY_RUN) {
    await langRef.set(metaData, { merge: true });
  }

  console.log(`  ✅ Done — ${words.length} words written, metadata updated.`);
}

// ── Main ──────────────────────────────────────────────────────────────────────

async function main() {
  if (!fs.existsSync(VOCABULARY_JSON_PATH)) {
    console.error(`❌ Vocabulary JSON not found at ${VOCABULARY_JSON_PATH}`);
    process.exit(1);
  }

  const raw  = fs.readFileSync(VOCABULARY_JSON_PATH, 'utf-8');
  const data = JSON.parse(raw);
  const languages = data.languages ?? [];

  if (languages.length === 0) {
    console.error('❌ No languages found in vocabulary JSON.');
    process.exit(1);
  }

  console.log(`Loaded ${languages.length} language(s) from ${path.basename(VOCABULARY_JSON_PATH)}.`);
  console.log(`Script version: ${SCRIPT_VERSION}`);

  // Upload languages with limited concurrency
  for (let i = 0; i < languages.length; i += CONCURRENCY) {
    const chunk = languages.slice(i, i + CONCURRENCY);
    await Promise.all(chunk.map(uploadLanguage));
  }

  console.log('\n🎉 Vocabulary upload complete.');
  process.exit(0);
}

main().catch((err) => {
  console.error('\n❌ Fatal error:', err.message);
  process.exit(1);
});

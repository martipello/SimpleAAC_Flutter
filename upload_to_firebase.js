// 1.npm init -y
//   npm install @google-cloud/storage
//   npm install sharp
//
// 2. Download your service account key file:
//    * Go to the **Firebase Console** -> **Project Settings** -> **Service Accounts**.
//    * Click **Generate New Private Key**, download the JSON file, and save it in your project directory as `serviceAccountKey.json`.
//
// 3. node upload_to_firebase.js
// ---


const { Storage } = require('@google-cloud/storage');
const fs = require('fs');
const path = require('path');
const { Jimp } = require('jimp');

// ============================================================================
// CONFIGURATION
// ============================================================================
const BUCKET_NAME = 'simpleaac-460e6.appspot.com';
const LOCAL_IMAGE_DIR = path.join(__dirname, 'aac_images');
const SELECTED_ALBUM = 'core';
const REMOTE_PATH_PREFIX = `simple_aac/images/${SELECTED_ALBUM}`;
const CONCURRENCY_LIMIT = 3; // Reduced slightly to stabilize network throughput
const MAX_RETRIES = 3;

const storage = new Storage({
  keyFilename: path.join(__dirname, 'serviceAccountKey.json'),
});

const bucket = storage.bucket(BUCKET_NAME);

/**
 * Helper function to pause execution
 */
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

/**
 * Checks Firebase Storage to see if the file already exists
 */
async function fileExistsInFirebase(destination) {
  try {
    const [exists] = await bucket.file(destination).exists();
    return exists;
  } catch (error) {
    // If the check fails, assume it doesn't exist so we attempt upload
    return false;
  }
}

/**
 * Resizes and uploads a file with an aggressive retry loop for rate limits.
 */
async function processAndUploadWithRetry(filePath, filename, retryCount = 0) {
  const destination = `${REMOTE_PATH_PREFIX}/${filename}`;

  // Skip if already in Firebase
  const alreadyExists = await fileExistsInFirebase(destination);
  if (alreadyExists) {
    console.log(`- Skipping ${filename}: Already exists in Firebase.`);
    return;
  }

  const fileRef = bucket.file(destination);

  try {
    // 1. Load and downscale the file to 256x256
    const image = await Jimp.read(filePath);
    image.resize({ w: 256, h: 256 });
    const compressedBuffer = await image.getBuffer('image/png');

    // 2. Upload buffer directly to Firebase
    await fileRef.save(compressedBuffer, {
      metadata: {
        contentType: 'image/png',
        cacheControl: 'public, max-age=31536000',
      },
    });

    console.log(`✅ Successfully uploaded: ${filename}`);
  } catch (error) {
    if (retryCount < MAX_RETRIES) {
      const waitTime = Math.pow(2, retryCount) * 1000; // Exponential backoff: 1s, 2s, 4s
      console.warn(`⚠️ Rate limited or network drop for ${filename}. Retrying in ${waitTime / 1000}s... (Attempt ${retryCount + 1}/${MAX_RETRIES})`);
      await sleep(waitTime);
      return processAndUploadWithRetry(filePath, filename, retryCount + 1);
    } else {
      console.error(`❌ Final Failure uploading ${filename} after ${MAX_RETRIES} retries:`, error.message);
    }
  }
}

/**
 * Main execution orchestration engine
 */
async function main() {
  if (!fs.existsSync(LOCAL_IMAGE_DIR)) {
    console.error(`Error: Local directory not found at ${LOCAL_IMAGE_DIR}`);
    process.exit(1);
  }

  const files = fs.readdirSync(LOCAL_IMAGE_DIR).filter(file => file.endsWith('.png'));
  console.log(`Found ${files.length} local files. Starting differential sync with Firebase...`);

  for (let i = 0; i < files.length; i += CONCURRENCY_LIMIT) {
    const chunk = files.slice(i, i + CONCURRENCY_LIMIT);
    const uploadPromises = chunk.map(filename => {
      const filePath = path.join(LOCAL_IMAGE_DIR, filename);
      return processAndUploadWithRetry(filePath, filename);
    });

    await Promise.all(uploadPromises);
    console.log(`Processed batch ${Math.min(i + CONCURRENCY_LIMIT, files.length)} / ${files.length}`);
  }

  console.log('\nDifferential sync process completely finished.');
}

main().catch(console.error);
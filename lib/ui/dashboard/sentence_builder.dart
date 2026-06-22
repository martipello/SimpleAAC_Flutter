import '../../api/models/word_sub_type.dart';
import '../../view_models/selected_words_view_model.dart';

/// One "spoken token" in the sentence — may represent multiple tiles.
/// e.g. ["mom", "s"] → SpeechGroup(spokenText:"moms", slotIds:[0,1])
class SpeechGroup {
  const SpeechGroup({
    required this.spokenText,
    required this.slotIds,
    required this.charStart,
    required this.charEnd,
  });

  /// What the TTS engine will speak for this token.
  final String spokenText;

  /// SlotIds of all tiles that highlight together during this token.
  final List<int> slotIds;

  /// Inclusive character start in [SentencePlan.ttsText].
  final int charStart;

  /// Exclusive character end in [SentencePlan.ttsText].
  final int charEnd;
}

class SentencePlan {
  const SentencePlan({required this.ttsText, required this.groups});

  /// Full text sent to the TTS engine.
  final String ttsText;

  /// Groups in sentence order, with character ranges set.
  final List<SpeechGroup> groups;
}

class SentenceBuilder {
  SentenceBuilder._();

  /// Converts a slot list into a [SentencePlan]:
  /// - Suffix words (subType == WordSubType.suffix) are appended to the
  ///   preceding word without a space, e.g. "mom"+"s" → "moms".
  /// - Both tiles in such a merge are highlighted simultaneously.
  static SentencePlan build(List<WordSlot> slots) {
    // Phase 1: group slots — collect (spokenText, slotIds) pairs.
    final raw = <({String text, List<int> ids})>[];

    for (final slot in slots) {
      final isSuffix = slot.word.subType == WordSubType.suffix;
      if (isSuffix && raw.isNotEmpty) {
        final prev = raw.removeLast();
        raw.add((
          text: prev.text + slot.word.text,
          ids: [...prev.ids, slot.slotId],
        ));
      } else {
        raw.add((text: slot.word.text, ids: [slot.slotId]));
      }
    }

    // Phase 2: build ttsText and calculate character ranges.
    final buffer = StringBuffer();
    final groups = <SpeechGroup>[];

    for (var i = 0; i < raw.length; i++) {
      final entry = raw[i];
      final start = buffer.length;
      buffer.write(entry.text);
      final end = buffer.length;
      if (i < raw.length - 1) buffer.write(' ');

      groups.add(SpeechGroup(
        spokenText: entry.text,
        slotIds: entry.ids,
        charStart: start,
        charEnd: end,
      ));
    }

    return SentencePlan(ttsText: buffer.toString(), groups: groups);
  }

  /// Returns the slot IDs that should be highlighted for the token whose
  /// spoken text starts at [charOffset] in [plan.ttsText].
  /// Returns an empty set if no match.
  static Set<int> findSlotIdsAtOffset(SentencePlan plan, int charOffset) {
    for (final group in plan.groups) {
      if (charOffset >= group.charStart && charOffset < group.charEnd) {
        return group.slotIds.toSet();
      }
    }
    return {};
  }
}

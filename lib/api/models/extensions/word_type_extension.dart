import 'package:flutter/cupertino.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../ui/theme/app_color.dart';
import '../word_sub_type.dart';
import '../word_type.dart';

extension WordTypeExtension on WordType? {
  Color getColor(final BuildContext context) {
    switch (this) {
      case WordType.nouns:
        return AppColor.wordTypeNoun;
      case WordType.other:
        return AppColor.wordTypeOther;
      case WordType.quicks:
        return AppColor.wordTypeQuick;
      case WordType.verbs:
        return AppColor.wordTypeVerb;
      default:
        return context.themeColors.primary;
    }
  }

  List<WordSubType> getSubTypes() {
    switch (this) {
      case WordType.nouns:
        return [
          WordSubType.people,
          WordSubType.animals,
          WordSubType.nature,
          WordSubType.time,
          WordSubType.places,
          WordSubType.things,
          WordSubType.ideas,
          WordSubType.drink,
          WordSubType.food,
        ];
      case WordType.other:
        return [
          WordSubType.home,
          WordSubType.clothes,
          WordSubType.extras,
          WordSubType.travel,
          WordSubType.art,
          WordSubType.games,
          WordSubType.music,
          WordSubType.body,
          WordSubType.love,
          WordSubType.occasion,
          WordSubType.learning,
        ];
      case WordType.quicks:
        return [
          WordSubType.favourites,
          WordSubType.pronouns,
          WordSubType.conjunctions,
          WordSubType.adjectives,
          WordSubType.propositionAndSound,
          WordSubType.phrases,
          WordSubType.suffix,
        ];
      case WordType.verbs:
        return [
          WordSubType.action,
          WordSubType.feeling,
          WordSubType.thought,
          WordSubType.sense,
          WordSubType.abverb,
          WordSubType.helping,
          WordSubType.strong,
        ];
      default:
        return [];
    }
  }
}

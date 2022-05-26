import 'package:flutter/cupertino.dart';

import '../../../ui/theme/base_theme.dart';
import '../word_sub_type.dart';
import '../word_type.dart';

extension WordTypeExtension on WordType? {
  Color getColor(BuildContext context) {
    switch (this) {
      case WordType.nouns:
        return colors(context).wordTypeNouns;
      case WordType.other:
        return colors(context).wordTypeOther;
      case WordType.quicks:
        return colors(context).wordTypeQuicks;
      case WordType.verbs:
        return colors(context).wordTypeVerbs;
      default:
        return colors(context).primary;
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

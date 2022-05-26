import 'package:flutter/cupertino.dart';

import '../../../ui/theme/base_theme.dart';
import '../word_sub_type.dart';

extension WordSubTypeExtension on WordSubType? {
  Color getColor(BuildContext context) {
    switch (this) {
      case WordSubType.people:
      case WordSubType.animals:
      case WordSubType.nature:
      case WordSubType.time:
      case WordSubType.places:
      case WordSubType.things:
      case WordSubType.ideas:
      case WordSubType.drink:
      case WordSubType.food:
        return colors(context).wordTypeNouns;
      case WordSubType.action:
      case WordSubType.feeling:
      case WordSubType.thought:
      case WordSubType.sense:
      case WordSubType.abverb:
      case WordSubType.helping:
      case WordSubType.strong:
        return colors(context).wordTypeVerbs;
      case WordSubType.favourites:
      case WordSubType.pronouns:
      case WordSubType.conjunctions:
      case WordSubType.adjectives:
      case WordSubType.propositionAndSound:
      case WordSubType.phrases:
      case WordSubType.suffix:
        return colors(context).wordTypeQuicks;
      case WordSubType.home:
      case WordSubType.clothes:
      case WordSubType.extras:
      case WordSubType.travel:
      case WordSubType.art:
      case WordSubType.games:
      case WordSubType.music:
      case WordSubType.body:
      case WordSubType.love:
      case WordSubType.occasion:
      case WordSubType.learning:
        return colors(context).wordTypeOther;
      default:
        return colors(context).primary;
    }
  }
}

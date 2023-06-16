import 'package:flutter/material.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../ui/theme/app_color.dart';
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
      return AppColor.wordTypeNoun;
      case WordSubType.action:
      case WordSubType.feeling:
      case WordSubType.thought:
      case WordSubType.sense:
      case WordSubType.abverb:
      case WordSubType.helping:
      case WordSubType.strong:
        return AppColor.wordTypeVerb;
      case WordSubType.favourites:
      case WordSubType.pronouns:
      case WordSubType.conjunctions:
      case WordSubType.adjectives:
      case WordSubType.propositionAndSound:
      case WordSubType.phrases:
      case WordSubType.suffix:
      return AppColor.wordTypeQuick;
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
      return AppColor.wordTypeOther;
      default:
        return context.themeColors.primary;
    }
  }

  IconData getIcon() {
    switch (this) {
      case WordSubType.people:
        return Icons.people_outlined;
      case WordSubType.animals:
        return Icons.blind_outlined;
      case WordSubType.nature:
        return Icons.nature_outlined;
      case WordSubType.time:
        return Icons.access_time_outlined;
      case WordSubType.places:
        return Icons.language_outlined;
      case WordSubType.things:
        return Icons.account_tree_outlined;
      case WordSubType.ideas:
        return Icons.lightbulb_outlined;
      case WordSubType.drink:
        return Icons.local_drink_outlined;
      case WordSubType.food:
        return Icons.fastfood_outlined;
      case WordSubType.action:
      case WordSubType.feeling:
      case WordSubType.thought:
      case WordSubType.sense:
      case WordSubType.abverb:
      case WordSubType.helping:
      case WordSubType.strong:
      case WordSubType.favourites:
        return Icons.favorite_border;
      case WordSubType.pronouns:
      case WordSubType.conjunctions:
      case WordSubType.adjectives:
      case WordSubType.propositionAndSound:
      case WordSubType.phrases:
      case WordSubType.suffix:
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
      default:
        return Icons.add;
    }
  }
}

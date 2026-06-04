import 'package:flutter/material.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../ui/theme/app_color.dart';
import '../word_sub_type.dart';
import '../word_type.dart';

extension WordTypeExtension on WordType? {
  Color getColor(BuildContext context) {
    switch (this) {
      case WordType.core:
        return AppColor.wordTypeQuick;
      case WordType.things:
        return AppColor.wordTypeNoun;
      case WordType.actions:
        return AppColor.wordTypeVerb;
      case WordType.describe:
        return AppColor.wordTypeOther;
      case WordType.social:
        return AppColor.wordTypeOther;
      case WordType.grammar:
        return AppColor.wordTypeOther;
      default:
        return context.themeColors.primary;
    }
  }

  IconData getIcon() {
    switch (this) {
      case WordType.core:
        return Icons.favorite_border_rounded;
      case WordType.things:
        return Icons.category_rounded;
      case WordType.actions:
        return Icons.directions_run_rounded;
      case WordType.describe:
        return Icons.palette_rounded;
      case WordType.social:
        return Icons.people_rounded;
      case WordType.grammar:
        return Icons.spellcheck_rounded;
      default:
        return Icons.grid_view_rounded;
    }
  }

  List<WordSubType> getSubTypes() {
    switch (this) {
      case WordType.core:
        // Core vocabulary is shown flat — no sub-tabs needed.
        return [];
      case WordType.things:
        return [
          WordSubType.people,
          WordSubType.animals,
          WordSubType.nature,
          WordSubType.food,
          WordSubType.drink,
          WordSubType.body,
          WordSubType.clothes,
          WordSubType.home,
          WordSubType.travel,
          WordSubType.places,
          WordSubType.art,
          WordSubType.music,
          WordSubType.games,
          WordSubType.occasions,
        ];
      case WordType.actions:
        return [
          WordSubType.action,
          WordSubType.helping,
          WordSubType.strong,
        ];
      case WordType.describe:
        return [
          WordSubType.adjectives,
          WordSubType.sense,
          WordSubType.feeling,
          WordSubType.thought,
        ];
      case WordType.social:
        return [
          WordSubType.phrases,
          WordSubType.favourites,
          WordSubType.greetings,
        ];
      case WordType.grammar:
        return [
          WordSubType.pronouns,
          WordSubType.conjunctions,
          WordSubType.prepositions,
          WordSubType.suffix,
        ];
      default:
        return [];
    }
  }
}

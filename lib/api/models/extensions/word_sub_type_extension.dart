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
      case WordSubType.food:
      case WordSubType.drink:
      case WordSubType.body:
      case WordSubType.clothes:
      case WordSubType.home:
      case WordSubType.travel:
      case WordSubType.places:
      case WordSubType.art:
      case WordSubType.music:
      case WordSubType.games:
      case WordSubType.occasions:
        return AppColor.wordTypeNoun;
      case WordSubType.action:
      case WordSubType.helping:
      case WordSubType.strong:
        return AppColor.wordTypeVerb;
      case WordSubType.adjectives:
      case WordSubType.sense:
      case WordSubType.feeling:
      case WordSubType.thought:
        return AppColor.wordTypeOther;
      case WordSubType.phrases:
      case WordSubType.favourites:
      case WordSubType.greetings:
        return AppColor.wordTypeQuick;
      case WordSubType.pronouns:
      case WordSubType.conjunctions:
      case WordSubType.prepositions:
      case WordSubType.suffix:
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
        return Icons.pets_outlined;
      case WordSubType.nature:
        return Icons.nature_outlined;
      case WordSubType.food:
        return Icons.fastfood_outlined;
      case WordSubType.drink:
        return Icons.local_drink_outlined;
      case WordSubType.body:
        return Icons.accessibility_new_outlined;
      case WordSubType.clothes:
        return Icons.checkroom_outlined;
      case WordSubType.home:
        return Icons.home_outlined;
      case WordSubType.travel:
        return Icons.flight_outlined;
      case WordSubType.places:
        return Icons.location_on_outlined;
      case WordSubType.art:
        return Icons.palette_outlined;
      case WordSubType.music:
        return Icons.music_note_outlined;
      case WordSubType.games:
        return Icons.sports_esports_outlined;
      case WordSubType.occasions:
        return Icons.celebration_outlined;
      case WordSubType.action:
        return Icons.directions_run_outlined;
      case WordSubType.helping:
        return Icons.volunteer_activism_outlined;
      case WordSubType.strong:
        return Icons.fitness_center;
      case WordSubType.adjectives:
        return Icons.text_fields_outlined;
      case WordSubType.sense:
        return Icons.visibility_outlined;
      case WordSubType.feeling:
        return Icons.mood_outlined;
      case WordSubType.thought:
        return Icons.lightbulb_outlined;
      case WordSubType.phrases:
        return Icons.chat_bubble_outline;
      case WordSubType.favourites:
        return Icons.favorite_border;
      case WordSubType.greetings:
        return Icons.waving_hand_outlined;
      case WordSubType.pronouns:
        return Icons.person_outline;
      case WordSubType.conjunctions:
        return Icons.link_outlined;
      case WordSubType.prepositions:
        return Icons.arrow_forward_outlined;
      case WordSubType.suffix:
        return Icons.add_outlined;
      default:
        return Icons.label_outline;
    }
  }
}

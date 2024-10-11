import 'package:flutter/material.dart';

import '../ability_saves/ability_saves_widget.dart';
import '../ability_scores/ability_scores_widget.dart';

class AbilityScoresAndSavesWidget extends StatelessWidget {
  const AbilityScoresAndSavesWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AbilityScoresWidget(),
        AbilitySavesWidget(),
      ],
    );
  }

}
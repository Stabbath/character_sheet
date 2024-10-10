import 'package:character_sheet/skills/skills_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ability_scores/ability_scores_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        home: CharacterSheet(),
      ),
    );
  }
}

class CharacterSheet extends StatelessWidget {
  const CharacterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AbilityScoresWidget(),
          SkillsWidget(),
        ]
      ),
    );
  }
}

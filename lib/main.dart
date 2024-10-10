import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ability_scores/ability_scores_widget.dart';
import 'skills/skills_widget.dart';
import 'names/names_widget.dart';

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
    return const Scaffold(
      body: Column(
        children: [
          Expanded(child: NamesWidget()),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: AbilityScoresWidget(),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SkillsWidget(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

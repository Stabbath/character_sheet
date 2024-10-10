import 'package:character_sheet/vtt_token/vtt_token_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'ability_scores/ability_scores_widget.dart';
import 'personality/personality_widget.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: LayoutGrid(
            areas: '''
              names names names names token
              abilities abilities skills skills personality
              abilities abilities skills skills personality
            ''',
            columnSizes: [1.fr, 1.fr, 1.fr, 1.fr, 1.fr],
            rowSizes: const [auto, auto, auto],
            columnGap: 16,
            rowGap: 16,
            children: [
              const NamesWidget().inGridArea('names'),
              const VttTokenWidget().inGridArea('token'),
              const AbilityScoresWidget().inGridArea('abilities'),
              const SkillsWidget().inGridArea('skills'),
              const PersonalityWidget().inGridArea('personality'),
            ],
          ),
        ),
      ),
    );
  }
}

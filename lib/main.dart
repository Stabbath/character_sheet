import 'package:character_sheet/biometrics/biometrics_widget.dart';
import 'package:character_sheet/generic_block/generic_block_widget.dart';
import 'package:character_sheet/origins/origins_widget.dart';
import 'package:character_sheet/image/image_widget.dart';
import 'package:character_sheet/stats_core/stats_core_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'ability_scores_and_saves.dart/ability_scores_and_saves_widget.dart';
import 'character_classes/character_classes_widget.dart';
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
              picture names names names names token
              picture origins origins biometrics biometrics biometrics
              classes classes personality personality personality personality
              abilities skills stats stats attacks attacks
              abilities skills actives actives actives actives
              abilities skills actives actives actives actives
              proficiencies passives passives passives passives passives
              cash cash equipment3 equipment3 equipment4 equipment4
              equipment1 equipment2 equipment3 equipment3 equipment4 equipment4
            ''',
            columnSizes: const [auto, auto, auto, auto, auto, auto],
            rowSizes: const [auto, auto, auto, auto, auto, auto, auto, auto, auto],
            columnGap: 16,
            rowGap: 16,
            children: [
              const ImageWidget().inGridArea('picture'),
              const NamesWidget().inGridArea('names'),
              const ImageWidget().inGridArea('token'),
              const BiometricsWidget().inGridArea('biometrics'),
              const OriginsWidget().inGridArea('origins'),
              const CharacterClassesWidget().inGridArea('classes'),
              const AbilityScoresAndSavesWidget().inGridArea('abilities'),
              const SkillsWidget().inGridArea('skills'),
              const StatsCoreWidget().inGridArea('stats'),
              const GenericBlockWidget(blockId: 'attacks').inGridArea('attacks'),
              const PersonalityWidget().inGridArea('personality'),
              const GenericBlockWidget(blockId: 'actives').inGridArea('actives'),
              const GenericBlockWidget(blockId: 'passives').inGridArea('passives'),
              const GenericBlockWidget(blockId: 'proficiencies').inGridArea('proficiencies'),
              const GenericBlockWidget(blockId: 'cash').inGridArea('cash'),
              const GenericBlockWidget(blockId: 'equipment 1').inGridArea('equipment1'),
              const GenericBlockWidget(blockId: 'equipment 2').inGridArea('equipment2'),
              const GenericBlockWidget(blockId: 'equipment 3').inGridArea('equipment3'),
              const GenericBlockWidget(blockId: 'equipment 4').inGridArea('equipment4'),
            ],
          ),
        ),
      ),
    );
  }
}

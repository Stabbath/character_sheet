import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/ability_saves_widget.dart';
import '../components/ability_scores_widget.dart';
import '../components/biometrics_widget.dart';
import '../components/character_classes_widget.dart';
import '../components/combat_widget.dart';
import '../components/generic_block_widget.dart';
import '../components/image_widget.dart';
import '../components/names_widget.dart';
import '../components/origins_widget.dart';
import '../components/personality_widget.dart';
import '../components/skills_widget.dart';
import '../components/stats_core_widget.dart';
import 'component.dart';
import 'layout_data.dart';
import 'providers.dart';

class CharacterSheet extends ConsumerWidget {
  const CharacterSheet({
    super.key,
  });

  List<Widget> buildChildren(LayoutData layoutData) {
    Set<String> areaNames = layoutData.getAreaNames();
    return areaNames.map((areaName) {
      final component = layoutData.components[areaName];
      if (component == null) return const SizedBox.shrink();
      return buildWidgetForComponent(component).inGridArea(areaName);
    }).toList();
  }

  Widget buildWidgetForComponent(Component component) {
    switch (component.type) {
      case 'image':
        return ImageWidget.fromComponent(component);
      case 'names':
        return NamesWidget.fromComponent(component);
      case 'origins':
        return OriginsWidget.fromComponent(component);
      case 'biometrics':
        return BiometricsWidget.fromComponent(component);
      case 'personality':
        return PersonalityWidget.fromComponent(component);
      case 'classes':
        return CharacterClassesWidget.fromComponent(component);
      case 'abilities':
        return AbilityScoresWidget.fromComponent(component);
      case 'saves':
        return AbilitySavesWidget.fromComponent(component);
      case 'skills':
        return SkillsWidget.fromComponent(component);
      case 'stats':
        return StatsCoreWidget.fromComponent(component);
      case 'generic_block':
        return GenericBlockWidget.fromComponent(component);
      case 'combat':
        return CombatWidget.fromComponent(component);
      default:
        throw Exception('Unknown component type: ${component.type}');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutData = ref.watch(layoutProvider);
    if (layoutData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: LayoutGrid(
            areas: layoutData.gridAreas,
            columnSizes: layoutData.columnSizes,
            rowSizes: layoutData.rowSizes,
            columnGap: layoutData.columnGap,
            rowGap: layoutData.rowGap,
            children: buildChildren(layoutData),
          ),
        ),
      ),
    );
  }
}

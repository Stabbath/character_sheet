import 'package:character_sheet/utils/yaml_utils.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

import '../../components/ability_saves_widget.dart';
import '../../components/ability_scores_widget.dart';
import '../../components/biometrics_widget.dart';
import '../../components/character_classes_widget.dart';
import '../../components/combat_widget.dart';
import '../../components/generic_block_widget.dart';
import '../../components/image_widget.dart';
import '../../components/names_widget.dart';
import '../../components/origins_widget.dart';
import '../../components/personality_widget.dart';
import '../../components/skills_widget.dart';
import 'data_bindings.dart';

class ComponentData {
  final String id;
  final String type;
  final Map<String, dynamic> readOnlyData;
  final Map<String, dynamic> defaultData;
  final Map<String, DataBinding> dataBindings;
  final Map<String, DataBinding> formulaBindings;

  ComponentData({
    required this.id,
    required this.type,
    required this.readOnlyData,
    required this.defaultData,
    required this.dataBindings,
    required this.formulaBindings,
  });

  factory ComponentData.fromYaml(String id, YamlMap yaml) {
    return ComponentData(
      id: id,
      type: yaml['type'],
      readOnlyData: mapFromYaml(yaml['readonly_data'] ?? YamlMap.wrap({})),
      defaultData: mapFromYaml(yaml['default_data'] ?? YamlMap.wrap({})),
      dataBindings: getDataBindingsFromYaml(yaml['data_bindings'] ?? YamlMap.wrap({})),
      formulaBindings: getDataBindingsFromYaml(yaml['formula_bindings'] ?? YamlMap.wrap({})),
    );
  }
}

Widget getWidgetFromComponent(ComponentData component) {
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
      return IntrinsicWidth(
        child: IntrinsicHeight(
          child: AbilityScoresWidget.fromComponent(component),
        ),
      );
    case 'saves':
      return IntrinsicWidth(
        child: IntrinsicHeight(
          child: AbilitySavesWidget.fromComponent(component),
        ),
      );
    case 'skills':
      return IntrinsicWidth(
        child: IntrinsicHeight(
          child: SkillsWidget.fromComponent(component),
        ),
      );
    case 'generic_block':
      return GenericBlockWidget.fromComponent(component);
    case 'combat':
      return IntrinsicWidth(
        child: IntrinsicHeight(
          child: CombatWidget.fromComponent(component),
        ),
      );
    default:
      throw Exception('Unknown component type: ${component.type}');
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';

import '../../formulae/character_level_from_classes.dart';
import '../../formulae/proficiency_bonus.dart';
import '../../utils/yaml_utils.dart';
import 'data_bindings.dart';

class Formula {
  final String id;
  final String type;
  final Map<String, dynamic> readOnlyData;
  final Map<String, dynamic> dataBindings;
  final Map<String, dynamic> formulaBindings;

  Formula({
    required this.id,
    required this.type,
    required this.readOnlyData,
    required this.dataBindings,
    required this.formulaBindings,
  });

  Formula.fromYaml(this.id, YamlMap yaml) :
    type = yaml['type'],
    readOnlyData = mapFromYaml(yaml['readonly_data'] ?? YamlMap.wrap({})),
    dataBindings = getDataBindingsFromYaml(yaml['data_bindings'] ?? YamlMap.wrap({})),
    formulaBindings = getDataBindingsFromYaml(yaml['formula_bindings'] ?? YamlMap.wrap({}));

  dynamic evaluate(WidgetRef ref) {
    throw UnimplementedError();
  }

  factory Formula.createFromYaml(String id, YamlMap yaml) {
    final type = yaml['type'];
    switch (type) {
      case 'character_level_from_classes':
        return CharacterLevelFromClasses.fromYaml(id, yaml);
      case 'proficiency_bonus_from_level':
        return ProficiencyBonusFromLevel.fromYaml(id, yaml);
      default:
        throw Exception('Unknown formula type: $type');
    }
  }
}

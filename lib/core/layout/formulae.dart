import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';

import '../../formulae/character_level_from_classes.dart';
import '../../formulae/proficiency_bonus.dart';
import '../../utils/yaml_utils.dart';
import 'data_bindings.dart';

class FormulaData {
  final String id;
  final String type;
  final Map<String, dynamic> readOnlyData;
  final Map<String, dynamic> dataBindings;
  final Map<String, dynamic> formulaBindings;

  FormulaData({
    required this.id,
    required this.type,
    required this.readOnlyData,
    required this.dataBindings,
    required this.formulaBindings,
  });

  factory FormulaData.fromYaml(String id, YamlMap yaml) {
    return FormulaData(
      id: id,
      type: yaml['type'],
      readOnlyData: mapFromYaml(yaml['readonly_data'] ?? YamlMap.wrap({})),
      dataBindings: getDataBindingsFromYaml(yaml['data_bindings'] ?? YamlMap.wrap({})),
      formulaBindings: getDataBindingsFromYaml(yaml['formula_bindings'] ?? YamlMap.wrap({})),
    );
  }
}

abstract class Formula {
  final String id;
  final FormulaData formulaData;

  Formula({
    required this.id,
    required this.formulaData
  });

  Formula.fromYaml(this.id, YamlMap yaml) : formulaData = FormulaData.fromYaml(id, yaml);

  dynamic evaluate(WidgetRef ref) {
    throw UnimplementedError();
  }
}

Formula createFormulaFromData(FormulaData formulaData) {
  switch (formulaData.type) {
    case 'character_level_from_classes':
      return CharacterLevelFromClasses(id: formulaData.id, formulaData: formulaData);
    case 'proficiency_bonus_from_level':
      return ProficiencyBonusFromLevel(id: formulaData.id, formulaData: formulaData);
    default:
      throw Exception('Unknown formula type: ${formulaData.type}');
  }
}

import 'package:character_sheet/utils/yaml_utils.dart';
import 'package:yaml/yaml.dart';

// TODO - like Component but for calculating derived stats

class Formula {
  final String id;
  final String type;
  final Map<String, dynamic> readOnlyData;
  final Map<String, dynamic> dataBindings;

  Formula({
    required this.id,
    required this.type,
    required this.readOnlyData,
    required this.dataBindings,
  });

  factory Formula.fromYaml(String id, YamlMap yaml) {
    return Formula(
      id: id,
      type: yaml['type'],
      readOnlyData: Map<String, dynamic>.from(yaml['readonly_data'] ?? {}),
      dataBindings: mapFromYaml(yaml['data_bindings'] ?? {}),
    );
  }
}
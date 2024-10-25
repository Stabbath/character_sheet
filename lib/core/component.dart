import 'package:yaml/yaml.dart';

class Component {
  final String id;
  final String type;
  final Map<String, dynamic> readOnlyData;
  final Map<String, dynamic> defaultData;
  final Map<String, String> dataBindings;

  Component({
    required this.id,
    required this.type,
    required this.readOnlyData,
    required this.defaultData,
    required this.dataBindings,
  });

  factory Component.fromYaml(String id, YamlMap yaml) {
    return Component(
      id: id,
      type: yaml['type'],
      readOnlyData: yaml['read_only_data'] ?? {},
      defaultData: yaml['default_data'] ?? {},
      dataBindings: yaml['data_bindings'] ?? {},
    );
  }
}
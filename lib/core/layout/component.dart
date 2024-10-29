import 'package:yaml/yaml.dart';

import 'data_bindings.dart';

class Component {
  final String id;
  final String type;
  final Map<String, dynamic> readOnlyData;
  final Map<String, dynamic> defaultData;
  final Map<String, DataBinding> dataBindings;

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
      readOnlyData: Map<String, dynamic>.from(yaml['readonly_data'] ?? {}),
      defaultData: Map<String, dynamic>.from(yaml['default_data'] ?? {}),
      dataBindings: getDataBindingsFromYaml(yaml['data_bindings'] ?? {}),
    );
  }
}

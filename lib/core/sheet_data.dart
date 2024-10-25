import 'package:yaml/yaml.dart';

class SheetData {
  Map<String, dynamic> data;

  SheetData(this.data);

  factory SheetData.fromYaml(YamlMap yaml) => SheetData(Map<String, dynamic>.from(yaml));

  dynamic getValue(String path) {
    List<String> keys = path.split('.');
    dynamic value = data;
    for (String key in keys) {
      value = (value as Map?)?[key];
      if (value == null) return null;
    }
    return value;
  }

  void setValue(String path, dynamic newValue) {
    List<String> keys = path.split('.');
    Map current = data;
    for (int i = 0; i < keys.length - 1; i++) {
      current = current.putIfAbsent(keys[i], () => {});
    }
    current[keys.last] = newValue;
  }
}

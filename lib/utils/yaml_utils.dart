import 'package:yaml/yaml.dart';

dynamic parseYamlValue(dynamic value) {
  if (value is YamlMap) {
    return mapFromYaml(value);
  } else if (value is YamlList) {
    return listFromYamlList(value);
  } else {
    return value;
  }
}

Map<String, dynamic> mapFromYaml(YamlMap yaml) {
  final Map<String, dynamic> result = {};
  yaml.forEach((key, value) {
    if (value is YamlMap) {
      result[key as String] = mapFromYaml(value);
    } else if (value is YamlList) {
      result[key as String] = listFromYamlList(value);
    } else {
      result[key as String] = value;
    }
  });
  return result;
}

List<dynamic> listFromYamlList(YamlList yamlList) {
  return yamlList.map((element) {
    if (element is YamlMap) {
      return mapFromYaml(element);
    } else if (element is YamlList) {
      return listFromYamlList(element);
    } else {
      return element;
    }
  }).toList();
}

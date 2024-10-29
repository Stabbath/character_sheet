import 'package:yaml/yaml.dart';

import '../providers.dart';
import '../sheet_data.dart';

class DataBinding<T> {
  final String inKey;
  final String outKey;

  DataBinding(this.inKey, this.outKey);

  T getInSheet(SheetData sheetData) {
    return sheetData.getValue(outKey);
  }

  Function(T value) createStateUpdater(SheetDataNotifier notifier) {
    return (newValue) {
      notifier.updateValue(outKey, newValue);
    };
  }
}

Map<String, DataBinding> getDataBindingsFromYaml(YamlMap yaml) {
  Map<String, DataBinding> bindings = {};

  void traverseMap(String inKeyPath, dynamic value) {
    if (value is YamlMap) {
      // if value is a map, recursively traverse it
      value.forEach((key, innerValue) {
        String newPath = inKeyPath.isEmpty ? key : '$inKeyPath.$key';
        traverseMap(newPath, innerValue);
      });
    } else {
      // For leaf nodes, value = outKey, and that's the binding we want to store
      bindings[inKeyPath] = DataBinding(inKeyPath, value);
    }
  }

  traverseMap('', yaml);
  return bindings;
}

String compressInKeyPath(List<String> keyPath) {
  return keyPath.join('.');
}

List<String> getMissingInKeysFromDataBindings(Map<String, DataBinding> data, List<String> requiredInKeyPaths) {
  List<String> missingKeyPaths = [];

  for (String inKeyPath in requiredInKeyPaths) {
    if (data[inKeyPath] == null) {
      missingKeyPaths.add(inKeyPath);
    }
  }

  return missingKeyPaths; // Will be empty if all key-chains are valid
}

List<String> buildInKeyPaths(List<String> inKeysParent, List<String> inKeysChild) {
  List<String> inKeyPaths = [];

  for (String inKey1 in inKeysParent) {
    for (String inKey2 in inKeysChild) {
      inKeyPaths.add(buildInKeyPath(inKey1, inKey2));
    }
  }

  return inKeyPaths;
}

String buildInKeyPath(String inKey1, String inKey2) {
  return '$inKey1.$inKey2';
}

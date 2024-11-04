import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

import 'sources.dart';

class SheetData {
  final SourceMap sourceMap;

  SheetData(this.sourceMap);
  SheetData.empty() : sourceMap = SourceMap.empty();
  SheetData.fromSourceMap(this.sourceMap);

  factory SheetData.fromFilePath(String path) {
    String contents = File(path).readAsStringSync();
    if (contents.isEmpty) {
      return SheetData.empty();
    }
    final yaml = loadYaml(contents);
    SourceMap sourceMap = SourceMap.empty();
    yaml.forEach((key, value) {
      sourceMap[key] = VariableSource(value: value);
    });
    return SheetData.fromSourceMap(sourceMap);
  }

  void saveToFilePath(String path) {
    File file = File(path);
    var yamlWriter = YamlWriter();
    String yamlString = yamlWriter.write(toYaml());
    file.writeAsStringSync(yamlString);
  }

  factory SheetData.fromYaml(Map yaml) {
    SourceMap sourceMap = SourceMap.empty();
    yaml.forEach((key, value) {
      sourceMap[key] = VariableSource(value: value);
    });
    return SheetData.fromSourceMap(sourceMap);
  }

  Map<String, dynamic> toYaml() {
    Map<String, dynamic> yaml = {};
    sourceMap.sources.forEach((key, source) {
      if (source is VariableSource) {
        yaml[key] = source.get();
      }
    });
    return yaml;
  }

  dynamic get(String path) {
    Source? source = sourceMap[path];
    print('SheetData.get: $path -> ${sourceMap[path]} -> ${source?.get(sourceMap: sourceMap)}');

    return sourceMap.getValue(path);
  }

  void set(String path, dynamic newValue) {
    Source? source = sourceMap[path];
    if (source is VariableSource) {
      source.setValue(newValue);
    } else {
      throw Exception('Cannot set value for non-variable source at path: $path');
    }
  }

  SheetData copyWith(String keyPath, dynamic newValue) {
    SourceMap newSourceMap = SourceMap.clone(sourceMap);
    Source? source = newSourceMap[keyPath];
    if (source is VariableSource) {
      source.setValue(newValue);
    } else {
      throw Exception('Cannot set value for non-variable source at path: $keyPath');
    }
    return SheetData(newSourceMap);
  }
}

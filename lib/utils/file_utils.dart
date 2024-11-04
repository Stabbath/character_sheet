import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

import '../core/layout_data.dart';
import '../core/sheet_data.dart';

// with validity checks - return null if invalid
SheetData? loadSheetFromPath(String path, LayoutData layoutData) {
  final File file = File(path);
  if (!file.existsSync()) {
    return null;
  }

  final String contents = file.readAsStringSync();
  if (contents.isEmpty) {
    return layoutData.generateDefaultSheetData(); // return default data if file is empty
  }

  final yaml = loadYaml(contents);
  if (yaml == null) {
    return null;
  }

  SheetData data = SheetData.fromYaml(yaml);
  return data;
}

Future<void> writeSheetToPath(String path, SheetData sheetData) async {
  File file = File(path);
  var yamlWriter = YamlWriter();
  String yamlString = yamlWriter.write(sheetData.toYaml());
  await file.writeAsString(yamlString);
}

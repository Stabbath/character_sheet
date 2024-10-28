import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

import '../core/layout_data.dart';
import '../core/sheet_data.dart';

// with validity checks - return null if invalid
LayoutData? loadLayoutFromPath(String path) {
  final File file = File(path);
  if (!file.existsSync()) {
    return null;
  }

  final String contents = file.readAsStringSync();
  if (contents.isEmpty) {
    return null;
  }

  final yaml = loadYaml(contents);
  if (yaml == null) {
    return null;
  }

  return LayoutData.fromYaml(yaml);
}

SheetData? loadSheetFromPath(String path, LayoutData layoutData) {
  final File file = File(path);
  if (!file.existsSync()) {
    return null;
  }

  final String contents = file.readAsStringSync();
  if (contents.isEmpty) {
    return layoutData.generateDefaultSheetData(); // TODO - return a new default SheetData
  }

  final yaml = loadYaml(contents);
  if (yaml == null) {
    return null;
  }

  SheetData out = SheetData.fromYaml(yaml);
  if (false)
    layoutData.crossCheckAndUpdateSheetData(out); // fill in missing fields; should probably not do this automatically on load
  return out;
}

Future<void> writeSheetToPath(String path, SheetData sheetData) async {
  File file = File(path);
  var yamlWriter = YamlWriter();
  String yamlString = yamlWriter.write(sheetData.toYaml());
  await file.writeAsString(yamlString);
}

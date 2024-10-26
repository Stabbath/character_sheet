// providers.dart

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

import 'layout_data.dart';
import 'sheet_data.dart';

Provider<AsyncValue<dynamic>> getKeyPathProvider(String keyPath) {
  return Provider<AsyncValue<dynamic>>((ref) {
    final sheetDataAsyncValue = ref.watch(sheetDataProvider);
    return sheetDataAsyncValue.whenData((sheetData) {
      return sheetData.getValue(keyPath);
    });
  });
}

// Configuration class to hold file paths
class Config {
  final String layoutPath;
  final String sheetPath;

  Config({required this.layoutPath, required this.sheetPath});
}

// Provider for the configuration
final configProvider = Provider<Config>((ref) {
  return Config(layoutPath: 'layout.yaml', sheetPath: 'test_sheet.yaml');
});

// Provider for LayoutData
final layoutProvider = FutureProvider<LayoutData>((ref) async {
  final config = ref.watch(configProvider);
  final layoutPath = config.layoutPath;
  final layoutFile = File(layoutPath);

  if (!await layoutFile.exists()) {
    throw Exception('Layout file not found at path $layoutPath');
  }

  final layoutYamlString = await layoutFile.readAsString();
  final layoutYaml = loadYaml(layoutYamlString);
  return LayoutData.fromYaml(layoutYaml);
});

// Provider for SheetData, depends on LayoutData
final sheetDataProvider = FutureProvider<SheetData>((ref) async {
  final config = ref.watch(configProvider);
  final sheetPath = config.sheetPath;
  final sheetFile = File(sheetPath);

  // Wait for the layout data to be loaded
  final layoutData = await ref.watch(layoutProvider.future);

  SheetData sheetData;

  if (!await sheetFile.exists()) {
    // If the sheet file doesn't exist, create it using default values from LayoutData
    if (kDebugMode) {
      final r2 =_generateDefaultSheetData(layoutData).runtimeType;
      print("should be map $r2");
    }
    sheetData = _generateDefaultSheetData(layoutData);

    // Write the default SheetData to the file
    await _writeSheetDataToFile(sheetFile, sheetData);
  } else {
    // If the sheet file exists, load it
    final dataYamlString = await sheetFile.readAsString();
    final dataYaml = loadYaml(dataYamlString);
    sheetData = SheetData.fromYaml(dataYaml);

    // Cross-check and update the sheet data with LayoutData defaults
    bool isUpdated = _crossCheckAndUpdateSheetData(sheetData, layoutData);

    // If any updates were made, write the updated SheetData back to the file
    if (isUpdated) {
      await _writeSheetDataToFile(sheetFile, sheetData);
    }
  }

  return sheetData;
});

// Helper function to generate default sheet data based on LayoutData
SheetData _generateDefaultSheetData(LayoutData layoutData) {
  final SheetData defaultData = SheetData.empty();

  for (var componentEntry in layoutData.components.entries) {
    final component = componentEntry.value;

    // Iterate through each default_data field
    component.defaultData.forEach((field, defaultValue) {
      // Retrieve the corresponding data_bindings path for the field
      final bindingPath = component.dataBindings[field];
      if (bindingPath == null || bindingPath.isEmpty) {
        // Throw error if missing binding
        throw Exception('Missing data binding for field "$field" in component "${componentEntry.key}"');
      }

      // Set the default value at the binding path
      defaultData.setValue(bindingPath, defaultValue);
    });
  }

  return defaultData;
}

// Helper function to cross-check and update sheet data with LayoutData
bool _crossCheckAndUpdateSheetData(SheetData sheetData, LayoutData layoutData) {
  bool updated = false;

  for (var componentEntry in layoutData.components.entries) {
    final component = componentEntry.value;

    // Iterate through each default_data field
    component.defaultData.forEach((field, defaultValue) {
      final bindingPath = component.dataBindings[field];
      if (bindingPath == null || bindingPath.isEmpty) {
        throw Exception('Missing data binding for field "$field" in component "${componentEntry.key}"');
      }

      // Check if the path exists in sheetDataMap
      if (sheetData.getValue(bindingPath) == null) {
        // Set the default value if missing
        sheetData.setValue(bindingPath, defaultValue);
        updated = true;
      }
    });
  }

  return updated;
}

// Helper function to write SheetData to a file
Future<void> _writeSheetDataToFile(File file, SheetData sheetData) async {
  var yamlWriter = YamlWriter();
  String yamlString = yamlWriter.write(sheetData.toYaml());
  await file.writeAsString(yamlString);
}

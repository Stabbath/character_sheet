import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

import 'layout_data.dart';
import 'sheet_data.dart';

// Notifier for SheetData to notify listeners of changes
class SheetDataNotifier extends StateNotifier<SheetData?> {
  SheetDataNotifier() : super(null);

  // Initialize the sheet data
  void initialize(SheetData sheetData) {
    state = sheetData;
  }

  // Function to update a value in the sheet data
  void updateValue(String keyPath, dynamic newValue) {
    state?.setValue(keyPath, newValue);
    // Trigger listeners by updating the state
    state = state;
  }

  dynamic getValue(String keyPath) => state?.getValue(keyPath);
}

// Provider for SheetData
final sheetDataProvider = StateNotifierProvider<SheetDataNotifier, SheetData?>((ref) {
  return SheetDataNotifier();
});

// Provider for LayoutData
final layoutProvider = StateProvider<LayoutData?>((ref) => null);

// Provider for specific key paths
StateNotifierProvider<KeyPathNotifier, dynamic> getKeyPathProvider(String keyPath) {
  return StateNotifierProvider<KeyPathNotifier, dynamic>((ref) {
    return KeyPathNotifier(ref, keyPath);
  });
}

// Notifier for KeyPath to handle updates to a specific path in SheetData
class KeyPathNotifier extends StateNotifier<dynamic> {
  KeyPathNotifier(this.ref, this._keyPath) : super(null) {
    // Initialize the state to the current value at the key path
    state = ref.read(sheetDataProvider.notifier).getValue(_keyPath);
  }

  final Ref ref;
  final String _keyPath;

  // Update function to notify SheetDataNotifier of a value change
  void update(dynamic newValue) {
    ref.read(sheetDataProvider.notifier).updateValue(_keyPath, newValue);
    state = newValue;
  }
}

// Initialize providers with loaded or default data
Future<void> initializeProviders(ProviderContainer container) async {
  // Load LayoutData
  final layoutPath = 'layout.yaml';
  final layoutFile = File(layoutPath);
  if (!layoutFile.existsSync()) {
    throw Exception('Layout file not found at path $layoutPath');
  }
  final layoutYamlString = await layoutFile.readAsString();
  final layoutYaml = loadYaml(layoutYamlString);
  final layoutData = LayoutData.fromYaml(layoutYaml);

  // Load SheetData
  final sheetPath = 'test_sheet.yaml';
  final sheetFile = File(sheetPath);
  SheetData sheetData;

  if (!sheetFile.existsSync()) {
    sheetData = _generateDefaultSheetData(layoutData);
    await _writeSheetDataToFile(sheetFile, sheetData);
  } else {
    final dataYamlString = await sheetFile.readAsString();

    if (dataYamlString.isEmpty) {
      sheetData = _generateDefaultSheetData(layoutData);
      await _writeSheetDataToFile(sheetFile, sheetData);
    } else {
      final dataYaml = loadYaml(dataYamlString);
      
      if (dataYaml == null) {
        throw Exception('Error loading yaml data from file $sheetPath');
      } else {
        sheetData = SheetData.fromYaml(dataYaml);
        _crossCheckAndUpdateSheetData(sheetData, layoutData);
        await _writeSheetDataToFile(sheetFile, sheetData);
      }
    }
  }

  // Set data in providers
  container.read(layoutProvider.notifier).state = layoutData;
  container.read(sheetDataProvider.notifier).initialize(sheetData);
}

// Helper functions to generate, cross-check, and write SheetData
SheetData _generateDefaultSheetData(LayoutData layoutData) {
  final SheetData defaultData = SheetData.empty();

  for (var componentEntry in layoutData.components.entries) {
    final component = componentEntry.value;
    component.defaultData.forEach((field, defaultValue) {
      final bindingPath = component.dataBindings[field];
      if (bindingPath == null || bindingPath.isEmpty) {
        throw Exception('Missing data binding for field "$field" in component "${componentEntry.key}"');
      }
      defaultData.setValue(bindingPath, defaultValue);
    });
  }

  return defaultData;
}

bool _crossCheckAndUpdateSheetData(SheetData sheetData, LayoutData layoutData) {
  bool updated = false;

  for (var componentEntry in layoutData.components.entries) {
    final component = componentEntry.value;
    component.defaultData.forEach((field, defaultValue) {
      final bindingPath = component.dataBindings[field];
      if (bindingPath == null || bindingPath.isEmpty) {
        throw Exception('Missing data binding for field "$field" in component "${componentEntry.key}"');
      }

      if (sheetData.getValue(bindingPath) == null) {
        sheetData.setValue(bindingPath, defaultValue);
        updated = true;
      }
    });
  }

  return updated;
}

Future<void> _writeSheetDataToFile(File file, SheetData sheetData) async {
  var yamlWriter = YamlWriter();
  String yamlString = yamlWriter.write(sheetData.toYaml());
  await file.writeAsString(yamlString);
}

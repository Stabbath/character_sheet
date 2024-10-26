import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';

import 'core/character_sheet_widget.dart';
import 'core/file_paths_provider.dart';
import 'core/layout_data.dart';
import 'core/sheet_data.dart';

void main() {
  // load stuff at startup, synchronously
  final filePaths = loadFilePathsSync();
  print('Current working directory: ${Directory.current.path}');
  
  runApp(ProviderScope(
    overrides: [
      // Override filePathsProvider with a custom notifier instance
      filePathsProvider.overrideWith((ref) => FilePathsNotifier()..setPaths(
        layoutPath: filePaths.layoutPath,
        sheetPath: filePaths.sheetPath,
      )),
    ],
    child: MainApp()
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CharacterSheet(),
    );
  }
}

// Function to load file paths synchronously
FilePaths loadFilePathsSync() {
  // Replace with actual logic if needed
  return FilePaths(layoutPath: 'layout.yaml', sheetPath: 'test_sheet.yaml');
}

// Function to load layout data synchronously
LayoutData loadLayoutDataSync(String layoutPath) {
  String layoutYamlString = File(layoutPath).readAsStringSync();
  final layoutYaml = loadYaml(layoutYamlString);
  return LayoutData.fromYaml(layoutYaml);
}

// Function to load sheet data synchronously
SheetData loadSheetDataSync(String sheetPath) {
  String dataYamlString = File(sheetPath).readAsStringSync();
  final dataYaml = loadYaml(dataYamlString);
  return SheetData.fromYaml(dataYaml);
}
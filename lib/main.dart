import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';

import 'core/character_sheet_wrapper.dart';
import 'core/layout_data.dart';
import 'core/providers.dart';
import 'core/sheet_data.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutData = ref.watch(layoutProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(layoutData?.name ?? "Waiting for layout data..."),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    _showSettingsDialog(context);
                  },
                );
              },
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: CharacterSheetWrapper(),
        ),
      ),
    );
  }
}

void _showSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final container = ProviderScope.containerOf(context, listen: false);
      return AlertDialog(
        title: const Text('Select Files'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                final XFile? layoutFile = await openFile(
                  acceptedTypeGroups: [
                    XTypeGroup(label: 'Layout Files', extensions: ['yaml'])
                  ],
                );
                if (layoutFile != null) {
                  final layoutYamlString = await File(layoutFile.path).readAsString();
                  final layoutYaml = loadYaml(layoutYamlString);
                  final layoutData = LayoutData.fromYaml(layoutYaml);
                  
                  container.read(layoutProvider.notifier).state = layoutData;
                  container.read(sheetDataProvider.notifier).initialize(layoutData.generateDefaultSheetData());
                }
              },
              child: const Text('Select Layout File'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final XFile? dataFile = await openFile(
                  acceptedTypeGroups: [
                    XTypeGroup(label: 'Data Files', extensions: ['yaml'])
                  ],
                );
                if (dataFile != null) {
                  final dataYamlString = await File(dataFile.path).readAsString();
                  final dataYaml = loadYaml(dataYamlString);
                  
                  final sheetData = SheetData.fromYaml(dataYaml);
                  container.read(sheetDataProvider.notifier).initialize(sheetData);
                }
              },
              child: const Text('Select Data File'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

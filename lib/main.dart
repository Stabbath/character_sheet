import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/character_sheet_wrapper.dart';
import 'core/providers/providers.dart';

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
                    _showSettingsDialog(context, ref);
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

void _showSettingsDialog(BuildContext context, WidgetRef ref) {
  var layoutPath = ref.read(layoutFilePathProvider);
  var sheetPath = ref.read(sheetFilePathProvider);

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
                  layoutPath = layoutFile.path;
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
                  sheetPath = dataFile.path;
                }
              },
              child: const Text('Select Data File'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Submit'),
            onPressed: () {
              initializeProviders(container, layoutPath, sheetPath);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

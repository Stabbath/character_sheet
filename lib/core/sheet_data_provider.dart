// SheetData state and debounced writing logic
import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

import 'file_paths_provider.dart';
import 'sheet_data.dart';

final sheetDataProvider = StateNotifierProvider<SheetDataNotifier, SheetData>((ref) {
  final filePaths = ref.watch(filePathsProvider);
  return SheetDataNotifier(filePaths.sheetPath);
});

class SheetDataNotifier extends StateNotifier<SheetData> {
  final String filePath;
  Timer? _debounceTimer;

  SheetDataNotifier(this.filePath) : super(SheetData({})) {
    _loadData();
  }

  Future<void> _loadData() async {
    String dataYamlString = await File(filePath).readAsString();
    final dataYaml = loadYaml(dataYamlString);
    state = SheetData.fromYaml(dataYaml);
  }

  // Debounced write to file
  void _scheduleWrite() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), _writeData);
  }

  Future<void> _writeData() async {
    var yamlWriter = YamlWriter();
    String yamlString = yamlWriter.write(state.data);
    await File(filePath).writeAsString(yamlString);
  }

  // Get or set data by path
  dynamic getValue(String path) => state.getValue(path);

  void setValue(String path, dynamic newValue) {
    state.setValue(path, newValue);
    _scheduleWrite();
  }
}

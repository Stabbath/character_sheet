// SheetData state and debounced writing logic
import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

import 'file_paths_provider.dart';
import 'sheet_data.dart';

final sheetDataProvider = NotifierProvider<SheetDataNotifier, SheetData>(SheetDataNotifier.new);

class SheetDataNotifier extends Notifier<SheetData> {
  Timer? _debounceTimer;

  @override
  SheetData build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    return _loadData();
  }

  SheetData _loadData() {
    final filePaths = ref.watch(filePathsProvider);
    String dataYamlString = File(filePaths.sheetPath).readAsStringSync();
    final dataYaml = loadYaml(dataYamlString);
    return SheetData.fromYaml(dataYaml);
  }

  dynamic getValue(String path) => state.getValue(path);

  void setValue(String path, dynamic newValue) {
    state.setValue(path, newValue);
    _scheduleWrite();
  }

  void _scheduleWrite() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), _writeData);
  }

  Future<void> _writeData() async {
    final filePaths = ref.watch(filePathsProvider);
    var yamlWriter = YamlWriter();
    String yamlString = yamlWriter.write(state.data);

    await File(filePaths.sheetPath).writeAsString(yamlString);
  }
}

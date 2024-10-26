import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';

import 'file_paths_provider.dart';
import 'layout_data.dart';

final layoutProvider = NotifierProvider<LayoutNotifier, LayoutData>(LayoutNotifier.new);

class LayoutNotifier extends Notifier<LayoutData> {
  @override
  LayoutData build() {
    final filePaths = ref.watch(filePathsProvider);
    return loadLayoutData(filePaths.layoutPath);
  }

  LayoutData loadLayoutData(String path) {
    String layoutYamlString = File(path).readAsStringSync();
    final layoutYaml = loadYaml(layoutYamlString);
    return LayoutData.fromYaml(layoutYaml);
  }
}

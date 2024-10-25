import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';

import 'file_paths_provider.dart';
import 'layout_data.dart';

final layoutProvider = FutureProvider<LayoutData>((ref) async {
  final filePaths = ref.watch(filePathsProvider);
  String layoutYamlString = await File(filePaths.layoutPath).readAsString();
  final layoutYaml = loadYaml(layoutYamlString);
  return LayoutData.fromYaml(layoutYaml);
});

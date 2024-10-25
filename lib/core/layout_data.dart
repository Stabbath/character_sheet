import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:yaml/yaml.dart';

import 'component.dart';

class LayoutData {
  final String gridAreas;
  final List<TrackSize> columnSizes;
  final List<TrackSize> rowSizes;
  final double columnGap;
  final double rowGap;
  final Map<String, Component> components;

  LayoutData({required this.gridAreas, required this.columnSizes, required this.rowSizes, required this.columnGap, required this.rowGap, required this.components});

  factory LayoutData.fromYaml(YamlMap yaml) {
    Map<String, Component> components = {};
    for (var entry in (yaml['components'] as Map).entries) {
      components[entry.key] = Component.fromYaml(entry.key, entry.value);
    }
    // TODO - columnSizes and rowSizes should be determined based on the gridAreas
    return LayoutData(
      gridAreas: yaml['layout'],
      columnSizes: [auto, auto, auto, auto, auto, auto],
      rowSizes: [auto, auto, auto, auto, auto, auto, auto, auto, auto],
      columnGap: 16.0,
      rowGap: 16.0,
      components: components,
    );
  }
}


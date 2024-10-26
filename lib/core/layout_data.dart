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

  LayoutData({
    required this.gridAreas,
    required this.columnSizes,
    required this.rowSizes,
    required this.columnGap,
    required this.rowGap,
    required this.components
  });

  factory LayoutData.fromYaml(YamlMap yaml) {
    final String layout = yaml['layout'];
    final rowCount = layout.split('\n').length - 1; // I guess the last line also includes a \n, so we get an extra row which just contains an empty string
    final columnCount = layout.split('\n')[0].split(' ').length; 

    Map<String, Component> components = {};
    for (var entry in (yaml['components']).entries) {
      components[entry.key] = Component.fromYaml(entry.key, entry.value);
    }

    return LayoutData(
      gridAreas: layout,
      columnSizes: List.generate(columnCount, (index) => auto),
      rowSizes: List.generate(rowCount, (index) => auto),
      columnGap: 16.0,
      rowGap: 16.0,
      components: components,
    );
  }

  Set<String> getAreaNames() {
    Set<String> areaNames = {};
    List<String> lines = gridAreas.trim().split('\n');
    for (String line in lines) {
      List<String> areas = line.trim().split(RegExp(r'\s+'));
      areaNames.addAll(areas);
    }
    return areaNames;
  }
}


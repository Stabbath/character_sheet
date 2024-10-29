import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:yaml/yaml.dart';

import 'components.dart';
import 'formulae.dart';
import '../sheet_data.dart';

class LayoutData {
  final String name;
  final String version;
  final String gridAreas;
  final List<TrackSize> columnSizes;
  final List<TrackSize> rowSizes;
  final double columnGap;
  final double rowGap;
  final Map<String, ComponentData> components;
  final Map<String, Formula> formulae;

  LayoutData({
    required this.name,
    required this.version,
    required this.gridAreas,
    required this.columnSizes,
    required this.rowSizes,
    required this.columnGap,
    required this.rowGap,
    required this.components,
    required this.formulae,
  });

  factory LayoutData.fromYaml(YamlMap yaml) {
    final String layout = yaml['layout'];
    final rowCount = layout.split('\n').length - 1; // I guess the last line also includes a \n, so we get an extra row which just contains an empty string
    final columnCount = layout.split('\n')[0].split(' ').length; 

    Map<String, ComponentData> components = {};
    for (var entry in (yaml['components']).entries) {
      components[entry.key] = ComponentData.fromYaml(entry.key, entry.value);
    }

    Map<String, Formula> formulae = {};
    for (var entry in (yaml['formulae']).entries) {
      formulae[entry.key] = createFormulaFromData(FormulaData.fromYaml(entry.key, entry.value));
    }

    return LayoutData(
      name: yaml['name'],
      version: yaml['version'],
      gridAreas: layout,
      columnSizes: List.generate(columnCount, (index) => auto),
      rowSizes: List.generate(rowCount, (index) => auto),
      columnGap: 16.0,
      rowGap: 16.0,
      components: components,
      formulae: formulae,
    );
  }

  Formula getFormulaFromOutKey(String key) {
    if (!formulae.containsKey(key)) {
      throw Exception('Unknown formula key: $key');
    }
    return formulae[key]!;
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

  SheetData generateDefaultSheetData() {
    final SheetData defaultData = SheetData.empty();

    for (var componentEntry in components.entries) {
      final component = componentEntry.value;
      component.defaultData.forEach((field, defaultValue) {
        final binding = component.dataBindings[field];
        if (binding == null) {
          throw Exception('Missing data binding for field "$field" in component "${componentEntry.key}"');
        }
        defaultData.setValue(binding.outKey, defaultValue);
      });
    }

    return defaultData;
  }

  bool crossCheckAndUpdateSheetData(SheetData sheetData) {
    bool updated = false;

    for (var componentEntry in components.entries) {
      final component = componentEntry.value;
      component.defaultData.forEach((field, defaultValue) {
        final binding = component.dataBindings[field];
        if (binding == null) {
          throw Exception('Missing data binding for field "$field" in component "${componentEntry.key}"');
        }

        if (sheetData.getValue(binding.outKey) == null) {
          sheetData.setValue(binding.outKey, defaultValue);
          updated = true;
        }
      });
    }

    return updated;
  }
}


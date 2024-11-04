import 'dart:io';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:yaml/yaml.dart';

import 'components.dart';
import 'sheet_data.dart';
import 'sources.dart';

class LayoutDefinition {
  final String name;
  final String version;
  final String description;
  final String author;

  final String layoutString;

  final SourceDefinitionMap sourceDefinitions;
  final ComponentDefinitionMap componentDefinitions;

  LayoutDefinition({
    required this.name,
    required this.version,
    required this.description,
    required this.author,
    required this.layoutString,
    required this.sourceDefinitions,
    required this.componentDefinitions,
  });

  LayoutDefinition.fromYaml(YamlMap yaml)
  : name = yaml['name'] ?? 'Unnamed Layout',
    version = yaml['version'] ?? '0.0.0',
    description = yaml['description'] ?? 'No description provided.',
    author = yaml['author'] ?? 'Unknown Author',
    layoutString = yaml['layout'],
    sourceDefinitions = SourceDefinitionMap.fromYaml(yaml['sources']),
    componentDefinitions = ComponentDefinitionMap.fromYaml(yaml['components']);

  LayoutDefinition.fromFilePath(String path) : this.fromYaml(loadYaml(File(path).readAsStringSync()));
}

class LayoutData {
  final LayoutDefinition definition;
  final String name;
  final String version;
  final String gridAreas;
  final List<TrackSize> columnSizes;
  final List<TrackSize> rowSizes;
  final double columnGap;
  final double rowGap;
  final ComponentMap componentMap;
  final SourceMap sourceMap;

  LayoutData({
    required this.definition,
    required this.name,
    required this.version,
    required this.gridAreas,
    required this.columnSizes,
    required this.rowSizes,
    required this.columnGap,
    required this.rowGap,
    required this.componentMap,
    required this.sourceMap,
  });

  LayoutData.fromDefinition(this.definition)
  : name = definition.name,
    version = definition.version,
    gridAreas = definition.layoutString,
    columnSizes = List.generate(definition.layoutString.split('\n')[0].split(' ').length, (index) => auto),
    rowSizes = List.generate(definition.layoutString.split('\n').length - 1, (index) => auto),
    columnGap = 16.0,
    rowGap = 16.0,
    componentMap = ComponentMap.fromDefinitions(definition.componentDefinitions),
    sourceMap = SourceMap.fromDefinitions(definition.sourceDefinitions);

  LayoutData.fromFilePath(String path) : this.fromDefinition(LayoutDefinition.fromFilePath(path));

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
    // Initialize a new SourceMap from the source definitions
    SourceMap sourceMap = SourceMap.fromDefinitions(definition.sourceDefinitions);
    return SheetData(sourceMap);
  }

  bool crossCheckAndUpdateSheetData(SheetData sheetData) {
    bool updated = false;

    // Get the current sources from the SheetData
    Map<String, Source> currentSources = sheetData.sourceMap.sources;

    // Get the defined sources from the layout definitions
    Map<String, SourceDefinition> definedSources = definition.sourceDefinitions.sources;

    // Add missing sources
    for (var key in definedSources.keys) {
      if (!currentSources.containsKey(key)) {
        // Create a new Source from the definition and add it to the SourceMap
        Source newSource = Source.fromDefinition(definedSources[key]!);
        sheetData.sourceMap.sources[key] = newSource;
        updated = true;
      }
    }

    return updated;
  }
}

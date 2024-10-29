import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'layout/components.dart';
import 'layout/layout_data.dart';
import 'providers.dart';

class CharacterSheet extends ConsumerWidget {
  const CharacterSheet({
    super.key,
  });

  List<Widget> buildChildren(LayoutData layoutData) {
    Set<String> areaNames = layoutData.getAreaNames();
    return areaNames.map((areaName) {
      final component = layoutData.components[areaName];
      if (component == null) return const SizedBox.shrink();
      return buildWidgetForComponent(component).inGridArea(areaName);
    }).toList();
  }

  Widget buildWidgetForComponent(ComponentData component) {
    return getWidgetFromComponent(component);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutData = ref.watch(layoutProvider);
    if (layoutData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: LayoutGrid(
        areas: layoutData.gridAreas,
        columnSizes: layoutData.columnSizes,
        rowSizes: layoutData.rowSizes,
        columnGap: layoutData.columnGap,
        rowGap: layoutData.rowGap,
        children: buildChildren(layoutData),
      ),
    );
  }
}

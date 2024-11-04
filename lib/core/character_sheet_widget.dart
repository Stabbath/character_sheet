import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/providers.dart';
import 'layout_data.dart';

class CharacterSheet extends ConsumerWidget {
  const CharacterSheet({
    super.key,
  });

  List<Widget> buildChildren(LayoutData layoutData) {
    Set<String> areaNames = layoutData.getAreaNames();
    return areaNames.map((areaName) {
      final component = layoutData.componentMap.components[areaName];
      if (component == null) return const SizedBox.shrink();
      return component.inGridArea(areaName);
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutData = ref.watch(layoutProvider);
    if (layoutData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return InteractiveViewer(
      constrained: false,
      panEnabled: true,
      scaleEnabled: true,
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

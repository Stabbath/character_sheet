// TODO - think about how to genericize Components
// each component needs a dataBindings map (where the inkey might be compound)
// same for formulaBindings
// use this to build the new SpellSheetWidget
// then we can think about refactoring the rest
import 'package:character_sheet/components/generic/section_header.dart';
import 'package:character_sheet/components/generic/spell_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/layout/components.dart';

abstract class Component extends ConsumerWidget {
  final String id;
  final ComponentData componentData;

  const Component({
    super.key,
    required this.id,
    required this.componentData,
  });

  Component.fromComponentData(this.componentData, {super.key})
    : id = componentData.id;

  factory Component.createFromComponent(ComponentData component) {
    switch (component.type) {
      case 'spell_sheet':
        return SpellSheetWidget.fromComponentData(component);
      default:
        throw Exception('Component type ${component.type} not recognized');
    }
  }
}

class SpellSheetWidget extends Component {
  SpellSheetWidget.fromComponentData(super.componentData, {super.key}) : super.fromComponentData();
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Afterwards, the Spell Sheet also needs to dynamically control how many spell blocks there are, and allow inputing spellcasting ability, with spell save dc and spell attack bonus automatically calculated.

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          SectionHeader(title: 'Spell Sheet'),
          Wrap(
            children: [
              SizedBox(
                width: 600,
                child: IntrinsicHeight(
                  child: SpellBlockWidget(
                    title: 'title',
                    currentSlots: 2,
                    maxSlots: 2,
                    onTitleChanged: (newValue) => (),
                    onCurrentSlotsChanged:  (newValue) => (),
                    onMaxSlotsChanged:  (newValue) => (),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
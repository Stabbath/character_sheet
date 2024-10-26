import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';
import 'ability_saves_widget.dart';
import 'ability_scores_widget.dart';

// TODO later - redesign this widget/component as a generic WRAPPER component, with special rules
// TODO - possibly also allow for data_bindings to have nested data, e.g. 'abilities.strength'

class AbilityScoresAndSavesWidget extends StatelessWidget {
  final String id;
  final Component component;
  final StateNotifierProvider<KeyPathNotifier, dynamic> abilitiesProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> savesProvider;

  const AbilityScoresAndSavesWidget({
    super.key,
    required this.id,
    required this.component,
    required this.abilitiesProvider,
    required this.savesProvider,
  });

  AbilityScoresAndSavesWidget.fromKeyPath({
    super.key,
    required this.id,
    required dataKeyPath,
  }) : abilitiesProvider = getKeyPathProvider(dataKeyPath).select(selector: (data) => data['abilities']),
       savesProvider = getKeyPathProvider(dataKeyPath).select(selector: (data) => data['saves']);

  factory AbilityScoresAndSavesWidget.fromComponent(Component component) {
    return AbilityScoresAndSavesWidget(
      id: component.id,
      component: component,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AbilityScoresWidget(
          id: '${id}_abilities',
          abilitiesProvider: abilitiesProvider,
        ),
        const AbilitySavesWidget(),
      ],
    );
  }
}

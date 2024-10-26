import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/component.dart';
import '../core/providers.dart';
import 'generic/ability_score_field.dart';
import 'generic/section_header.dart';

class AbilityScoresWidget extends ConsumerWidget {
  final String id;
  final StateNotifierProvider<KeyPathNotifier, dynamic> strengthProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> dexterityProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> constitutionProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> intelligenceProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> wisdomProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> charismaProvider;

  const AbilityScoresWidget({
    super.key,
    required this.id,
    required this.strengthProvider,
    required this.dexterityProvider,
    required this.constitutionProvider,
    required this.intelligenceProvider,
    required this.wisdomProvider,
    required this.charismaProvider,
  });

  AbilityScoresWidget.fromKeyPaths({
    super.key,
    required this.id,
    required strengthKeyPath,
    required dexterityKeyPath,
    required constitutionKeyPath,
    required intelligenceKeyPath,
    required wisdomKeyPath,
    required charismaKeyPath,
  }) : strengthProvider = getKeyPathProvider(strengthKeyPath),
       dexterityProvider = getKeyPathProvider(dexterityKeyPath),
       constitutionProvider = getKeyPathProvider(constitutionKeyPath),
       intelligenceProvider = getKeyPathProvider(intelligenceKeyPath),
       wisdomProvider = getKeyPathProvider(wisdomKeyPath),
       charismaProvider = getKeyPathProvider(charismaKeyPath);

  factory AbilityScoresWidget.fromComponent(Component component) {
    return AbilityScoresWidget.fromKeyPaths(
      id: component.id,
      strengthKeyPath: component.dataBindings['strength'],
      dexterityKeyPath: component.dataBindings['dexterity'],
      constitutionKeyPath: component.dataBindings['constitution'],
      intelligenceKeyPath: component.dataBindings['intelligence'],
      wisdomKeyPath: component.dataBindings['wisdom'],
      charismaKeyPath: component.dataBindings['charisma'],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Ability Scores'),
          AbilityScoreField(
            label: 'Strength',
            abilityScoreProvider: strengthProvider,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Dexterity',
            abilityScoreProvider: dexterityProvider,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Constitution',
            abilityScoreProvider: constitutionProvider,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Intelligence',
            abilityScoreProvider: intelligenceProvider,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Wisdom',
            abilityScoreProvider: wisdomProvider,
          ),
          const SizedBox(height: 10),
          AbilityScoreField(
            label: 'Charisma',
            abilityScoreProvider: charismaProvider,
          ),
        ],
      ),
    );
  }
}
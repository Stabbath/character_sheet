import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';
import 'generic/section_header.dart';
import 'generic/skill_field.dart';

class AbilitySavesWidget extends ConsumerWidget {
  final String id;
  final StateNotifierProvider<KeyPathNotifier, dynamic> strengthProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> dexterityProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> constitutionProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> intelligenceProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> wisdomProvider;
  final StateNotifierProvider<KeyPathNotifier, dynamic> charismaProvider;

  const AbilitySavesWidget({
    super.key,
    required this.id,
    required this.strengthProvider,
    required this.dexterityProvider,
    required this.constitutionProvider,
    required this.intelligenceProvider,
    required this.wisdomProvider,
    required this.charismaProvider,
  });

  AbilitySavesWidget.fromKeyPaths({
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
  
  factory AbilitySavesWidget.fromComponent(Component component) {
    print(component.dataBindings['strength']);
    print(component.dataBindings['strength']['bonus']);

    return AbilitySavesWidget.fromKeyPaths(
      id: component.id,
      strengthKeyPath: component.dataBindings['strength']['bonus'],
      dexterityKeyPath: component.dataBindings['dexterity']['bonus'],
      constitutionKeyPath: component.dataBindings['constitution']['bonus'],
      intelligenceKeyPath: component.dataBindings['intelligence']['bonus'],
      wisdomKeyPath: component.dataBindings['wisdom']['bonus'],
      charismaKeyPath: component.dataBindings['charisma']['bonus'],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Ability Saves'),
          SkillField(
            label: 'Strength', 
            skillProvider: strengthProvider,
          ),
          const SizedBox(height: 10),
          SkillField(
            label: 'Dexterity',
            skillProvider: dexterityProvider,
          ),
          const SizedBox(height: 10),
          SkillField(
            label: 'Constitution', 
            skillProvider: constitutionProvider,
          ),
          const SizedBox(height: 10),
          SkillField(
            label: 'Intelligence',
            skillProvider: intelligenceProvider,
          ),
          const SizedBox(height: 10),
          SkillField(
            label: 'Wisdom',
            skillProvider: wisdomProvider,
          ),
          const SizedBox(height: 10),
          SkillField(
            label: 'Charisma',
            skillProvider: charismaProvider,
          ),
        ],
      ),
    );
  }
}
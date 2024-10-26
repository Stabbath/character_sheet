import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/providers.dart';
import 'generic/section_header.dart';
import 'generic/skill_field.dart';

class AbilitySavesWidget extends ConsumerWidget {
  final String id;
  final Provider<dynamic> strengthProvider;
  final Provider<dynamic> dexterityProvider;
  final Provider<dynamic> constitutionProvider;
  final Provider<dynamic> intelligenceProvider;
  final Provider<dynamic> wisdomProvider;
  final Provider<dynamic> charismaProvider;

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
    return AbilitySavesWidget.fromKeyPaths(
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
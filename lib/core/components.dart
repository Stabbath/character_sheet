import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';

import '../components/all.dart';

enum ComponentType {
  spell_sheet,
  image,
  names,
  origins,
  biometrics,
  personality,
  classes,
  abilities,
  saves,
  skills,
  generic_block,
  combat;

  List<String> getIterableSourceKeys() {
    switch (this) {
      case ComponentType.abilities:
      case ComponentType.saves:
        return [
          'strength', 'dexterity', 'constitution', 'intelligence', 'wisdom', 'charisma'
        ];
      case ComponentType.skills:
        return [
          'acrobatics', 'animal_handling', 'arcana', 'athletics', 'deception', 'history', 'insight', 'intimidation',
          'investigation', 'medicine', 'nature', 'perception', 'performance', 'persuasion', 'religion', 'sleight_of_hand',
          'stealth', 'survival'
        ];
      default:
        return [];
    }
  }

  List<String> get requiredSources {
    switch (this) {
      case ComponentType.spell_sheet:
        return [
          'title',
          'spellcasting_ability',
          'spellcasting_ability_options',
          'spell_save_dc',
          'spell_attack',
          'lists',
          'default_lists_entry',
          'default_list_entry',
        ];
      case ComponentType.image:
        return ['path'];
      case ComponentType.names:
        return ['names', 'titles'];
      case ComponentType.origins:
        return ['race', 'background'];
      case ComponentType.biometrics:
        return ['age', 'height', 'weight', 'eyes', 'skin', 'hair'];
      case ComponentType.personality:
        return ['traits', 'ideals', 'bonds', 'flaws'];
      case ComponentType.classes:
        return ['list', 'character_level', 'proficiency_bonus'];
      case ComponentType.abilities:
        return [
          'strength.base', 'strength.bonus',
          'dexterity.base', 'dexterity.bonus',
          'constitution.base', 'constitution.bonus',
          'intelligence.base', 'intelligence.bonus',
          'wisdom.base', 'wisdom.bonus',
          'charisma.base', 'charisma.bonus'
        ];
      case ComponentType.saves:
        return [
          'strength.proficiency', 'strength.bonus',
          'dexterity.proficiency', 'dexterity.bonus',
          'constitution.proficiency', 'constitution.bonus',
          'intelligence.proficiency', 'intelligence.bonus',
          'wisdom.proficiency', 'wisdom.bonus',
          'charisma.proficiency', 'charisma.bonus',
          'proficiency_bonus'
        ];
      case ComponentType.skills:
        return [
          'acrobatics.proficiency', 'acrobatics.bonus',
          'animal_handling.proficiency', 'animal_handling.bonus',
          'arcana.proficiency', 'arcana.bonus',
          'athletics.proficiency', 'athletics.bonus',
          'deception.proficiency', 'deception.bonus',
          'history.proficiency', 'history.bonus',
          'insight.proficiency', 'insight.bonus',
          'intimidation.proficiency', 'intimidation.bonus',
          'investigation.proficiency', 'investigation.bonus',
          'medicine.proficiency', 'medicine.bonus',
          'nature.proficiency', 'nature.bonus',
          'perception.proficiency', 'perception.bonus',
          'performance.proficiency', 'performance.bonus',
          'persuasion.proficiency', 'persuasion.bonus',
          'religion.proficiency', 'religion.bonus',
          'sleight_of_hand.proficiency', 'sleight_of_hand.bonus',
          'stealth.proficiency', 'stealth.bonus',
          'survival.proficiency', 'survival.bonus',
          'proficiency_bonus'
        ];
      case ComponentType.generic_block:
        return ['title', 'content'];
      case ComponentType.combat:
        return [
          'hp', 'max_hp', 'exhaustion', 'max_exhaustion', 'temp_hp', 'armor_class', 'initiative', 'speed', 'notes'
        ];
      default:
        return [];
    }
  }

  List<String> getMissingSources(Map<String, String> sources) {
    List<String> requiredSources = this.requiredSources;
    List<String> missingSources = [];
    for (String source in requiredSources) {
      if (!sources.containsKey(source)) {
        missingSources.add(source);
      }
    }
    return missingSources;
  }
}

class ComponentDefinition {
  final ComponentType type;
  final Map<String, String> sourceKeys;

  ComponentDefinition({
    required this.type,
    required this.sourceKeys,
  });
}

class ComponentDefinitionMap {
  Map<String, ComponentDefinition> components;

  ComponentDefinitionMap({
    required this.components,
  });

  factory ComponentDefinitionMap.fromYaml(YamlMap yaml) {
    Map<String, ComponentDefinition> components = {};

    yaml.forEach((key, value) {
      if (value is YamlMap) {
        ComponentType type = ComponentType.values.firstWhere((e) => e.toString().split('.').last == value['type']);
        Map<String, String> sources = {};
        if (value['sources'] is YamlMap) {
          value['sources'].forEach((sourceKey, sourceValue) {
            sources[sourceKey] = sourceValue;
          });
        }

        final missingSources = type.getMissingSources(sources);
        if (missingSources.isNotEmpty) {
          throw Exception('Component definition for $key is missing required sources for type $type: $missingSources');
        }

        components[key] = ComponentDefinition(
          type: type,
          sourceKeys: sources,
        );
      }
    });

    return ComponentDefinitionMap(components: components);
  }

  ComponentDefinition? operator [](String key) {
    return components.containsKey(key) ? components[key] : null;
  }

  void operator []=(String key, ComponentDefinition value) {
    components[key] = value;
  }

  void forEach(void Function(String key, ComponentDefinition value) f) {
    components.forEach(f);
  }
}

abstract class Component extends ConsumerWidget {
  final ComponentDefinition definition;

  const Component({
    super.key,
    required this.definition,
  });

  factory Component.fromDefinition(ComponentDefinition definition) {
    switch (definition.type) {
      case ComponentType.spell_sheet:
        return SpellSheetWidget(definition: definition);
      case ComponentType.image:
        return ImageWidget(definition: definition);
      case ComponentType.names:
        return NamesWidget(definition: definition);
      case ComponentType.origins:
        return OriginsWidget(definition: definition);
      case ComponentType.biometrics:
        return BiometricsWidget(definition: definition);
      case ComponentType.personality:
        return PersonalityWidget(definition: definition);
      case ComponentType.classes:
        return CharacterClassesWidget(definition: definition);
      case ComponentType.abilities:
        return AbilityScoresWidget(definition: definition);
      case ComponentType.saves:
        return AbilitySavesWidget(definition: definition);
      case ComponentType.skills:
        return SkillsWidget(definition: definition);
      case ComponentType.generic_block:
        return GenericBlockWidget(definition: definition);
      case ComponentType.combat:
        return CombatWidget(definition: definition);
      default:
        throw Exception('Unknown component type: ${definition.type}');
    }
  }
}

class ComponentMap {
  final Map<String, Component> components = {};

  ComponentMap.fromDefinitions(ComponentDefinitionMap definitions) {
    definitions.forEach((key, definition) {
      components[key] = Component.fromDefinition(definition);
    });
  }

  Component? operator [](String key) => components[key];

  void operator []=(String key, Component value) {
    components[key] = value;
  }

  void forEach(void Function(String key, Component value) f) {
    components.forEach(f);
  }
}

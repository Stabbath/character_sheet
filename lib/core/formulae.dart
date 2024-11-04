import 'sources.dart';

abstract class Formula {
  final Map<String, String> parameterMap;
  Formula.fromParameterMap(this.parameterMap);

  factory Formula.fromDefinition(FunctionSourceDefinition definition) {
    switch (definition.formulaKey) {
      case 'character_level_from_classes':
        return CharacterLevelFromClasses.fromParameterMap(definition.parameterMap);
      case 'proficiency_bonus_from_level':
        return ProficiencyBonusFromLevel.fromParameterMap(definition.parameterMap);
      default:
        throw Exception('Unknown formula key: ${definition.formulaKey}');
    }
  }

  dynamic evaluate(SourceMap sourceMap);
}

class CharacterLevelFromClasses extends Formula {
  CharacterLevelFromClasses.fromParameterMap(super.parameterMap) : super.fromParameterMap();

  @override
  num evaluate(SourceMap sourceMap) {
    final classList = sourceMap.getValue(parameterMap['class_list']!);
    num totalLevel = 0;
    for (int i = 0; i < classList.length; i++) {
      totalLevel += classList[i]["level"];
    }
    return totalLevel;
  }
}

class ProficiencyBonusFromLevel extends Formula {
  ProficiencyBonusFromLevel.fromParameterMap(super.parameterMap) : super.fromParameterMap();

  @override
  num evaluate(SourceMap sourceMap) {
    final characterLevel = sourceMap.getValue(parameterMap['character_level']!);

    print('ProficiencyBonusFromLevel.evaluate: ${parameterMap['character_level']} -> $characterLevel -> ${((characterLevel - 1) / 4).floor() + 2}');

    return ((characterLevel - 1) / 4).floor() + 2;
  }
}


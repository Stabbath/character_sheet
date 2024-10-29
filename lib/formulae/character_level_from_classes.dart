import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/layout/formulae.dart';
import '../core/providers.dart';

class CharacterLevelFromClasses extends Formula {
  CharacterLevelFromClasses({required super.id, required super.formulaData});

  @override
  num evaluate(WidgetRef ref) {
    final classList = ref.read(sheetDataProvider)!.getValue(formulaData.dataBindings["classlist"].outKey);
    num totalLevel = 0;
    for (int i = 0; i < classList.length; i++) {
      totalLevel += classList[i]["level"];
    }
    return totalLevel;
  }
}

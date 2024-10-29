import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/layout/formulae.dart';
import '../core/providers.dart';

class ProficiencyBonusFromLevel extends Formula {
  ProficiencyBonusFromLevel({required super.id, required super.formulaData});

  @override
  num evaluate(WidgetRef ref) {
    final levelCalculator = ref.read(layoutProvider.select((state) => state?.getFormulaFromOutKey('character_level')));
    final totalLevel = levelCalculator!.evaluate(ref);
    return ((totalLevel - 1) / 4).floor() + 2;
  }
}

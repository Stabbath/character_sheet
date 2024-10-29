import 'package:character_sheet/formulae/character_level_from_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

num getProficiencyBonus(WidgetRef ref) {
  final totalLevel = getTotalLevel(ref);
  return ((totalLevel - 1) / 4).floor() + 2;
}

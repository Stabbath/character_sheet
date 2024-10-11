import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ability_saves_model.dart';

final abilityScoresProvider = StateNotifierProvider<AbilityScoresNotifier, AbilitSavesModel>(
  (ref) => AbilityScoresNotifier(),
);

class AbilityScoresNotifier extends StateNotifier<AbilitSavesModel> {
  AbilityScoresNotifier() : super(AbilitSavesModel());

  void updateScore(String ability, int value) {
    state = AbilitSavesModel(
      strength: ability == 'strength' ? value : state.strength,
      dexterity: ability == 'dexterity' ? value : state.dexterity,
      constitution: ability == 'constitution' ? value : state.constitution,
      intelligence: ability == 'intelligence' ? value : state.intelligence,
      wisdom: ability == 'wisdom' ? value : state.wisdom,
      charisma: ability == 'charisma' ? value : state.charisma,
    );
  }
}

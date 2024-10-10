import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ability_scores_model.dart';

final abilityScoresProvider = StateNotifierProvider<AbilityScoresNotifier, AbilityScoresModel>(
  (ref) => AbilityScoresNotifier(),
);

class AbilityScoresNotifier extends StateNotifier<AbilityScoresModel> {
  AbilityScoresNotifier() : super(AbilityScoresModel());

  void updateScore(String ability, int value) {
    state = AbilityScoresModel(
      strength: ability == 'strength' ? value : state.strength,
      dexterity: ability == 'dexterity' ? value : state.dexterity,
      constitution: ability == 'constitution' ? value : state.constitution,
      intelligence: ability == 'intelligence' ? value : state.intelligence,
      wisdom: ability == 'wisdom' ? value : state.wisdom,
      charisma: ability == 'charisma' ? value : state.charisma,
    );
  }
}

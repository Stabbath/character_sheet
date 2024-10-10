
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'personality_model.dart';

final personalityProvider = StateNotifierProvider<PersonalityNotifier, PersonalityModel>(
  (ref) => PersonalityNotifier(),
);

class PersonalityNotifier extends StateNotifier<PersonalityModel> {
  PersonalityNotifier() : super(PersonalityModel());

  void updatePersonalityTraits(String newPersonalityTraits) {
    state = state.copyWith(personalityTraits: newPersonalityTraits);
  }

  void updateIdeals(String newIdeals) {
    state = state.copyWith(ideals: newIdeals);
  }

  void updateBonds(String newBonds) {
    state = state.copyWith(bonds: newBonds);
  }

  void updateFlaws(String newFlaws) {
    state = state.copyWith(flaws: newFlaws);
  }
}

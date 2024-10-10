import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'character_class_model.dart';

class CharacterClassesNotifier extends StateNotifier<List<CharacterClassModel>> {
  CharacterClassesNotifier() : super([]);

  void addClass() {
    state = [...state, CharacterClassModel(name: '', level: 0)];
  }

  void removeClass(int index) {
    if (index >= 0 && index < state.length) {
      state = [...state]..removeAt(index);
    }
  }

  void updateClass(int index, CharacterClassModel updatedClass) {
    if (index >= 0 && index < state.length) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) updatedClass else state[i]
      ];
    }
  }
}

final characterClassesProvider =
    StateNotifierProvider<CharacterClassesNotifier, List<CharacterClassModel>>(
  (ref) => CharacterClassesNotifier(),
);

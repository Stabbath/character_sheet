import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'origins_model.dart';

class OriginsNotifier extends StateNotifier<OriginsModel> {
  OriginsNotifier() : super(OriginsModel(race: '', background: ''));

  void updateRace(String newRace) {
    state = state.copyWith(race: newRace);
  }

  void updateBackground(String newBackground) {
    state = state.copyWith(background: newBackground);
  }
}

final originsProvider = StateNotifierProvider<OriginsNotifier, OriginsModel>(
  (ref) => OriginsNotifier(),
);

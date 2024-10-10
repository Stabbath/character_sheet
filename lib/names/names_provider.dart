import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'names_model.dart';

final namesProvider = StateNotifierProvider<NamesNotifier, NamesModel>(
  (ref) => NamesNotifier(),
);

class NamesNotifier extends StateNotifier<NamesModel> {
  NamesNotifier() : super(NamesModel());

  void updateName(String newName) {
    state = NamesModel(
      name: newName,
      alias: state.alias,
      titles: state.titles,
    );
  }

  void updateAlias(String newAlias) {
    state = NamesModel(
      name: state.name,
      alias: newAlias,
      titles: state.titles,
    );
  }

  void updateTitles(String newTitles) {
    state = NamesModel(
      name: state.name,
      alias: state.alias,
      titles: newTitles,
    );
  }
}

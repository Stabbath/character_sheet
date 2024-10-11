import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/string_utils.dart';
import 'generic_block_model.dart';

class GenericBlockNotifier extends StateNotifier<GenericBlockModel> {
  GenericBlockNotifier(super.model);

  void updateTitle(String newTitle) {
    state = state.copyWith(title: newTitle);
  }

  void updateContent(String newContent) {
    state = state.copyWith(content: newContent);
  }
}

final genericBlockProviderFamily =
    StateNotifierProvider.family<GenericBlockNotifier, GenericBlockModel, String>(
  (ref, blockId) {
    // TODO - Placeholder initial data; replace this with data retrieval logic
    final initialData = {'title': capitalizeWords(blockId), 'content': 'Content'};
    return GenericBlockNotifier(GenericBlockModel.fromJson(blockId, initialData));
  },
);

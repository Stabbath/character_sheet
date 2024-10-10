import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'vtt_token_model.dart';

final vttTokenProvider = StateNotifierProvider<VttTokenNotifier, VttTokenModel>((ref) {
  return VttTokenNotifier();
});

class VttTokenNotifier extends StateNotifier<VttTokenModel> {
  VttTokenNotifier() : super(VttTokenModel(imagePath: ''));

  void setImagePath(String newPath) {
    state = VttTokenModel(imagePath: newPath);
  }
}

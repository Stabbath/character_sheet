import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'image_model.dart';

final ImageProvider = StateNotifierProvider<VttTokenNotifier, ImageModel>((ref) {
  return VttTokenNotifier();
});

class VttTokenNotifier extends StateNotifier<ImageModel> {
  VttTokenNotifier() : super(ImageModel(imagePath: ''));

  void setImagePath(String newPath) {
    state = ImageModel(imagePath: newPath);
  }
}

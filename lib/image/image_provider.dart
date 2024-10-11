import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'image_model.dart';

final imageProvider = StateNotifierProvider<ImageNotifier, ImageModel>((ref) {
  return ImageNotifier();
});

class ImageNotifier extends StateNotifier<ImageModel> {
  ImageNotifier() : super(ImageModel(imagePath: ''));

  void setImagePath(String newPath) {
    state = ImageModel(imagePath: newPath);
  }
}

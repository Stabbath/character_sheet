import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'biometrics_model.dart';

class BiometricsNotifier extends StateNotifier<BiometricsModel> {
  BiometricsNotifier() : super(BiometricsModel(age: 0, height: 0, weight: 0, eyes: '', skin: '', hair: ''));

  void updateAge(int newAge) {
    state = state.copyWith(age: newAge);
  }

  void updateHeight(double newHeight) {
    state = state.copyWith(height: newHeight);
  }

  void updateWeight(double newWeight) {
    state = state.copyWith(weight: newWeight);
  }

  void updateEyes(String newEyeColor) {
    state = state.copyWith(eyes: newEyeColor);
  }

  void updateSkin(String newSkinColor) {
    state = state.copyWith(skin: newSkinColor);
  }

  void updateHair(String newHairColor) {
    state = state.copyWith(hair: newHairColor);
  }
}

final biometricsProvider = StateNotifierProvider<BiometricsNotifier, BiometricsModel>((ref) {
  return BiometricsNotifier();
});

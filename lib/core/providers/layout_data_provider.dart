import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout_data.dart';

final layoutProvider = StateNotifierProvider<LayoutNotifier, LayoutData?>((ref) {
  return LayoutNotifier(ref);
});

class LayoutNotifier extends StateNotifier<LayoutData?> {
  final Ref ref;
  LayoutNotifier(this.ref) : super(null);

  void initialize(LayoutData? layoutData) {
    state = layoutData;
  }
}

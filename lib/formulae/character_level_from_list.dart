import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';

num getTotalLevel(WidgetRef ref) {
  final classList = ref.watch(sheetDataProvider.select((state) => state != null ? state.getValue("classes.list") : []));
  num totalLevel = 0;
  for (int i = 0; i < classList.length; i++) {
    totalLevel += classList[i]["level"];
  }
  return totalLevel;
}


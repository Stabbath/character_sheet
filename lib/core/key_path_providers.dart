import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sheet_data.dart';
import 'sheet_data_provider.dart';

Provider<dynamic> getKeyPathProvider(String keyPath) {
  return Provider<dynamic>((ref) {
    return ref.watch(sheetDataProvider.select((state) => _getValueFromState(state, keyPath)));
  });
}

dynamic _getValueFromState(SheetData state, String keyPath) {
  state.getValue(keyPath);
}

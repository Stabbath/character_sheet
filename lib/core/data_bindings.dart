import 'providers.dart';
import 'sheet_data.dart';

class DataBindings {
  final Map<String, DataBinding<dynamic>> map;

  DataBindings(this.map);
}

class DataBinding<T> {
  final String key;
  final T value;

  DataBinding(this.key, this.value);

  T getInSheet(SheetData sheetData) {
    return sheetData.getValue(key) as T;
  }

  void setInSheet(SheetData sheetData, T newValue) {
    sheetData.setValue(key, newValue);
  }

  Function(dynamic value) createStateUpdater(SheetDataNotifier notifier) {
    return (newValue) {
      notifier.updateValue(key, newValue);
    };
  }
}

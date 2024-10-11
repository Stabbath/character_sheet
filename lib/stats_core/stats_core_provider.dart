import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'stats_core_model.dart';

class StatsCoreProvider extends StateNotifier<StatsCoreModel> {
  StatsCoreProvider() : super(
    StatsCoreModel(dynamicStats: {
      "hp": {
          "currentValue": 0,
          "maxValue": 0
      },
      "exhaustion": {
          "currentValue": 0,
          "maxValue": 0
      }
    }, staticStats: {
      "temp_hp": 0,
      "armor_class": 0,
      "initiative": 0,
      "speed": 0,
      "proficiency_bonus": 0
    }));

  void updateDynamicStat(String key, int currentValue, int maxValue) {
    state = state.copyWith(
      dynamicStats: {
        ...state.dynamicStats,
        key: {
          'currentValue': currentValue,
          'maxValue': maxValue,
        },
      },
    );
  }

  void updateStaticStat(String key, int value) {
    state = state.copyWith(
      staticStats: {
        ...state.staticStats,
        key: value,
      },
    );
  }
}

final statsCoreProvider = StateNotifierProvider<StatsCoreProvider, StatsCoreModel>(
  (ref) => StatsCoreProvider(),
);

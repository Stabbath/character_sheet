class StatsCoreModel {
  final Map<String, Map<String, int>> dynamicStats;
  final Map<String, int> staticStats;

  StatsCoreModel({required this.dynamicStats, required this.staticStats});

  factory StatsCoreModel.fromJson(Map<String, dynamic> json) {
    return StatsCoreModel(
      dynamicStats: (json['status']['dynamic'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          value as Map<String, int>,
        ),
      ),
      staticStats: (json['status']['static'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, value as int),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': {
        'dynamic': dynamicStats.map((key, value) => MapEntry(key, value)),
        'static': staticStats,
      },
    };
  }

  StatsCoreModel copyWith({
    Map<String, Map<String, int>>? dynamicStats,
    Map<String, int>? staticStats,
  }) {
    return StatsCoreModel(
      dynamicStats: dynamicStats ?? this.dynamicStats,
      staticStats: staticStats ?? this.staticStats,
    );
  }
}



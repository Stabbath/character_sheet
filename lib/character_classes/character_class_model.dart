class CharacterClassModel {
  String name;
  int level;

  CharacterClassModel({required this.name, required this.level});

  // To facilitate JSON parsing if needed later
  factory CharacterClassModel.fromJson(Map<String, dynamic> json) {
    return CharacterClassModel(
      name: json['name'] ?? '',
      level: json['level'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
    };
  }
}

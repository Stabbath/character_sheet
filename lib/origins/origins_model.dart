class OriginsModel {
  final String race;
  final String background;

  OriginsModel({required this.race, required this.background});

  factory OriginsModel.fromJson(Map<String, dynamic> json) {
    return OriginsModel(
      race: json['race'] as String,
      background: json['background'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'race': race,
      'background': background,
    };
  }

  OriginsModel copyWith({String? race, String? background}) {
    return OriginsModel(
      race: race ?? this.race,
      background: background ?? this.background,
    );
  }
}

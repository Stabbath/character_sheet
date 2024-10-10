class BiometricsModel {
  final int age;
  final double height;
  final double weight;
  final String eyes;
  final String skin;
  final String hair;

  BiometricsModel({
    required this.age,
    required this.height,
    required this.weight,
    required this.eyes,
    required this.skin,
    required this.hair,
  });

  BiometricsModel copyWith({
    int? age,
    double? height,
    double? weight,
    String? eyes,
    String? skin,
    String? hair,
  }) {
    return BiometricsModel(
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      eyes: eyes ?? this.eyes,
      skin: skin ?? this.skin,
      hair: hair ?? this.hair,
    );
  }

  factory BiometricsModel.fromJson(Map<String, dynamic> json) {
    return BiometricsModel(
      age: json['age'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      eyes: json['eyes'],
      skin: json['skin'],
      hair: json['hair'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'height': height,
      'weight': weight,
      'eyes': eyes,
      'skin': skin,
      'hair': hair,
    };
  }
}

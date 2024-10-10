class PersonalityModel {
  String personalityTraits;
  String ideals;
  String bonds;
  String flaws;

  PersonalityModel({
    this.personalityTraits = '',
    this.ideals = '',
    this.bonds = '',
    this.flaws = '',
  });

  PersonalityModel copyWith({
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
  }) {
    return PersonalityModel(
      personalityTraits: personalityTraits ?? this.personalityTraits,
      ideals: ideals ?? this.ideals,
      bonds: bonds ?? this.bonds,
      flaws: flaws ?? this.flaws,
    );
  }

  factory PersonalityModel.fromJson(Map<String, dynamic> json) {
    return PersonalityModel(
      personalityTraits: json['personalityTraits'] as String,
      ideals: json['ideals'] as String,
      bonds: json['bonds'] as String,
      flaws: json['flaws'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personalityTraits': personalityTraits,
      'ideals': ideals,
      'bonds': bonds,
      'flaws': flaws,
    };
  }
}

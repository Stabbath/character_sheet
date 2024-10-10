class SkillsModel {
  int acrobatics;
  int animalHandling;
  int arcana;
  int athletics;
  int deception;
  int history;
  int insight;
  int intimidation;
  int investigation;
  int medicine;
  int nature;
  int perception;
  int performance;
  int persuasion;
  int religion;
  int sleightOfHand;
  int stealth;
  int survival;

  SkillsModel({
    this.acrobatics = 0,
    this.animalHandling = 0,
    this.arcana = 0,
    this.athletics = 0,
    this.deception = 0,
    this.history = 0,
    this.insight = 0,
    this.intimidation = 0,
    this.investigation = 0,
    this.medicine = 0,
    this.nature = 0,
    this.perception = 0,
    this.performance = 0,
    this.persuasion = 0,
    this.religion = 0,
    this.sleightOfHand = 0,
    this.stealth = 0,
    this.survival = 0,
  });

  factory SkillsModel.fromJson(Map<String, dynamic> json) {
    return SkillsModel(
      acrobatics: json['acrobatics'],
      animalHandling: json['animalHandling'],
      arcana: json['arcana'],
      athletics: json['athletics'],
      deception: json['deception'],
      history: json['history'],
      insight: json['insight'],
      intimidation: json['intimidation'],
      investigation: json['investigation'],
      medicine: json['medicine'],
      nature: json['nature'],
      perception: json['perception'],
      performance: json['performance'],
      persuasion: json['persuasion'],
      religion: json['religion'],
      sleightOfHand: json['sleightOfHand'],
      stealth: json['stealth'],
      survival: json['survival'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'acrobatics': acrobatics,
      'animalHandling': animalHandling,
      'arcana': arcana,
      'athletics': athletics,
      'deception': deception,
      'history': history,
      'insight': insight,
      'intimidation': intimidation,
      'investigation': investigation,
      'medicine': medicine,
      'nature': nature,
      'perception': perception,
      'performance': performance,
      'persuasion': persuasion,
      'religion': religion,
      'sleightOfHand': sleightOfHand,
      'stealth': stealth,
      'survival': survival,
    };
  }
}

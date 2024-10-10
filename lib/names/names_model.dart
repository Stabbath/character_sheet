class NamesModel {
  String name;
  String alias;
  String titles;

  NamesModel({
    this.name = '',
    this.alias = '',
    this.titles = '',
  });

  factory NamesModel.fromJson(Map<String, dynamic> json) {
    return NamesModel(
      name: json['name'],
      alias: json['alias'],
      titles: json['titles'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'alias': alias,
      'titles': titles,
    };
  }
}

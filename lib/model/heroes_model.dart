import 'dart:convert';

class HeroesModel {
  String? name;
  String? birthYear;
  int? deathYear;
  String? description;
  int? ascensionYear;

  HeroesModel(
      {this.name,
      this.birthYear,
      this.deathYear,
      this.description,
      this.ascensionYear});

  factory HeroesModel.fromJson(Map<dynamic, dynamic> json) {
    return HeroesModel(
      name: json['name'],
      birthYear: json['birth_year'].toString(),
      deathYear: json['death_year'],
      description: json['description'],
      ascensionYear: json['ascension_year'],
    );
  }

  static Map<String, dynamic> toHeroJson(HeroesModel heroesModel) {
    return {
      'name': heroesModel.name,
      'birth_year': heroesModel.birthYear,
      'death_year': heroesModel.deathYear,
      'description': heroesModel.description,
      'ascension_year': heroesModel.ascensionYear,
    };
  }

  static String encode(List<HeroesModel> hero) => json.encode(hero
      .map<Map<dynamic, dynamic>>((hero) => HeroesModel.toHeroJson(hero))
      .toList());

  static List<HeroesModel> decode(String hero) =>
      (json.decode(hero) as List<dynamic>)
          .map<HeroesModel>((item) => HeroesModel.fromJson(item))
          .toList();
}

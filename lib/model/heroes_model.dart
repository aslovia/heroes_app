

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
}

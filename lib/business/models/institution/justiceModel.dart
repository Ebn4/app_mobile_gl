class JusticeModel {
  final List<CasierJudiciaire> casiers;

  JusticeModel({
    required this.casiers,
  });

  factory JusticeModel.fromJson(Map<String, dynamic> json) {
    var casiersList = json['casiers'] as List?;
    List<CasierJudiciaire> casiers = casiersList?.map((i) => CasierJudiciaire.fromJson(i)).toList() ?? [];
    
    return JusticeModel(
      casiers: casiers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'casiers': casiers.map((casier) => casier.toJson()).toList(),
    };
  }
}

class CasierJudiciaire {
  final String? numero_casier;
  final String? date_jugement;
  final String? tribunal;
  final String? nature_infraction;
  final String? peine;
  final String? statut;

  CasierJudiciaire({
    this.numero_casier,
    this.date_jugement,
    this.tribunal,
    this.nature_infraction,
    this.peine,
    this.statut,
  });

  factory CasierJudiciaire.fromJson(Map<String, dynamic> json) {
    return CasierJudiciaire(
      numero_casier: json['numero_casier'],
      date_jugement: json['date_jugement'],
      tribunal: json['tribunal'],
      nature_infraction: json['nature_infraction'],
      peine: json['peine'],
      statut: json['statut'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero_casier': numero_casier,
      'date_jugement': date_jugement,
      'tribunal': tribunal,
      'nature_infraction': nature_infraction,
      'peine': peine,
      'statut': statut,
    };
  }
}

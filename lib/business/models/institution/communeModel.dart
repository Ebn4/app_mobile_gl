class CommuneModel {
  final ActeNaissance? acte_naissance;

  CommuneModel({
    this.acte_naissance,
  });

  factory CommuneModel.fromJson(Map<String, dynamic> json) {
    return CommuneModel(
      acte_naissance: json['acte_naissance'] != null ? ActeNaissance.fromJson(json['acte_naissance']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'acte_naissance': acte_naissance?.toJson(),
    };
  }
}

class ActeNaissance {
  final String? numero_acte;
  final String? date_naissance;
  final String? lieu_naissance;
  final String? pere_nom;
  final String? pere_prenom;
  final String? mere_nom;
  final String? mere_prenom;
  final String? officier_etat_civil;
  final String? date_delivrance;
  final String? commune_delivrance;

  ActeNaissance({
    this.numero_acte,
    this.date_naissance,
    this.lieu_naissance,
    this.pere_nom,
    this.pere_prenom,
    this.mere_nom,
    this.mere_prenom,
    this.officier_etat_civil,
    this.date_delivrance,
    this.commune_delivrance,
  });

  factory ActeNaissance.fromJson(Map<String, dynamic> json) {
    return ActeNaissance(
      numero_acte: json['numero_acte'],
      date_naissance: json['date_naissance'],
      lieu_naissance: json['lieu_naissance'],
      pere_nom: json['pere_nom'],
      pere_prenom: json['pere_prenom'],
      mere_nom: json['mere_nom'],
      mere_prenom: json['mere_prenom'],
      officier_etat_civil: json['officier_etat_civil'],
      date_delivrance: json['date_delivrance'],
      commune_delivrance: json['commune_delivrance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero_acte': numero_acte,
      'date_naissance': date_naissance,
      'lieu_naissance': lieu_naissance,
      'pere_nom': pere_nom,
      'pere_prenom': pere_prenom,
      'mere_nom': mere_nom,
      'mere_prenom': mere_prenom,
      'officier_etat_civil': officier_etat_civil,
      'date_delivrance': date_delivrance,
      'commune_delivrance': commune_delivrance,
    };
  }
}

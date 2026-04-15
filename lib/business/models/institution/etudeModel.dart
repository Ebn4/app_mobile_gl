class EtudeModel {
  final List<CarteEtudiant> cartes;

  EtudeModel({
    required this.cartes,
  });

  factory EtudeModel.fromJson(Map<String, dynamic> json) {
    var cartesList = json['cartes'] as List?;
    List<CarteEtudiant> cartes = cartesList?.map((i) => CarteEtudiant.fromJson(i)).toList() ?? [];
    
    return EtudeModel(
      cartes: cartes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartes': cartes.map((carte) => carte.toJson()).toList(),
    };
  }
}

class CarteEtudiant {
  final String? numero_carte;
  final String? etablissement;
  final String? filiere;
  final String? niveau;
  final String? annee_academique;
  final String? date_delivrance;
  final String? date_expiration;
  final String? statut;

  CarteEtudiant({
    this.numero_carte,
    this.etablissement,
    this.filiere,
    this.niveau,
    this.annee_academique,
    this.date_delivrance,
    this.date_expiration,
    this.statut,
  });

  factory CarteEtudiant.fromJson(Map<String, dynamic> json) {
    return CarteEtudiant(
      numero_carte: json['numero_carte'],
      etablissement: json['etablissement'],
      filiere: json['filiere'],
      niveau: json['niveau'],
      annee_academique: json['annee_academique'],
      date_delivrance: json['date_delivrance'],
      date_expiration: json['date_expiration'],
      statut: json['statut'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero_carte': numero_carte,
      'etablissement': etablissement,
      'filiere': filiere,
      'niveau': niveau,
      'annee_academique': annee_academique,
      'date_delivrance': date_delivrance,
      'date_expiration': date_expiration,
      'statut': statut,
    };
  }
}

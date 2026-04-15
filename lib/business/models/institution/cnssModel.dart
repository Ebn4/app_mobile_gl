class CnssModel {
  final String? numero_assure;
  final String? date_affiliation;
  final String? categorie;
  final String? statut_cotisation;
  final String? dernier_paiement;
  final String? employeur;
  final String? nni_employeur;

  CnssModel({
    this.numero_assure,
    this.date_affiliation,
    this.categorie,
    this.statut_cotisation,
    this.dernier_paiement,
    this.employeur,
    this.nni_employeur,
  });

  factory CnssModel.fromJson(Map<String, dynamic> json) {
    return CnssModel(
      numero_assure: json['numero_assure'],
      date_affiliation: json['date_affiliation'],
      categorie: json['categorie'],
      statut_cotisation: json['statut_cotisation'],
      dernier_paiement: json['dernier_paiement'],
      employeur: json['employeur'],
      nni_employeur: json['nni_employeur'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero_assure': numero_assure,
      'date_affiliation': date_affiliation,
      'categorie': categorie,
      'statut_cotisation': statut_cotisation,
      'dernier_paiement': dernier_paiement,
      'employeur': employeur,
      'nni_employeur': nni_employeur,
    };
  }
}

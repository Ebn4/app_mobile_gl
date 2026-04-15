class TransportModel {
  final String numero_permis;
  final String date_delivrance;
  final String lieu_delivrance;
  final int delivreur;
  final int id_conducteur;
  final String id_categorie;
  final String date_expiration;
  final String statut;

  TransportModel({
    required this.numero_permis,
    required this.date_delivrance,
    required this.lieu_delivrance,
    required this.delivreur,
    required this.id_conducteur,
    required this.id_categorie,
    required this.date_expiration,
    required this.statut,
  });

  factory TransportModel.fromJson(Map<String, dynamic> json) {
    return TransportModel(
      numero_permis: json['numero_permis'] ?? '',
      date_delivrance: json['date_delivrance'] ?? '',
      lieu_delivrance: json['lieu_delivrance'] ?? '',
      delivreur: json['delivreur'] ?? 0,
      id_conducteur: json['id_conducteur'] ?? 0,
      id_categorie: json['id_categorie'] ?? '',
      date_expiration: json['date_expiration'] ?? '',
      statut: json['statut'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero_permis': numero_permis,
      'date_delivrance': date_delivrance,
      'lieu_delivrance': lieu_delivrance,
      'delivreur': delivreur,
      'id_conducteur': id_conducteur,
      'id_categorie': id_categorie,
      'date_expiration': date_expiration,
      'statut': statut,
    };
  }
}

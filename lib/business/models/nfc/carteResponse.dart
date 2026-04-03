class CarteResponse {
    String numeroCarte;
    String nni;
    String nom;
    String postnom;
    String prenom;
    String sexe;
    DateTime dateDeNaissance;
    String lieuDeNaissance;
    String photoPasseport;

    CarteResponse({
        required this.numeroCarte,
        required this.nni,
        required this.nom,
        required this.postnom,
        required this.prenom,
        required this.sexe,
        required this.dateDeNaissance,
        required this.lieuDeNaissance,
        required this.photoPasseport,
    });

    factory CarteResponse.fromJson(Map<String, dynamic> json) => CarteResponse(
        numeroCarte: json["numero_carte"],
        nni: json["nni"],
        nom: json["nom"],
        postnom: json["postnom"],
        prenom: json["prenom"],
        sexe: json["sexe"],
        dateDeNaissance: DateTime.parse(json["date_de_naissance"]),
        lieuDeNaissance: json["lieu_de_naissance"],
        photoPasseport: json["photo_passeport"],
    );

    Map<String, dynamic> toJson() => {
        "numero_carte": numeroCarte,
        "nni": nni,
        "nom": nom,
        "postnom": postnom,
        "prenom": prenom,
        "sexe": sexe,
        "date_de_naissance": "${dateDeNaissance.year.toString().padLeft(4, '0')}-${dateDeNaissance.month.toString().padLeft(2, '0')}-${dateDeNaissance.day.toString().padLeft(2, '0')}",
        "lieu_de_naissance": lieuDeNaissance,
        "photo_passeport": photoPasseport,
    };
}

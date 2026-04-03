class Citizen {
    String nom;
    String postnom;
    String sexe;
    String lieuDeNaissance;
    String nomMere;
    String email;
    String nni;
    String prenom;
    DateTime dateDeNaissance;
    String nomPere;
    String telephone;
    DateTime dateEnregistrement;

    Citizen({
        required this.nom,
        required this.postnom,
        required this.sexe,
        required this.lieuDeNaissance,
        required this.nomMere,
        required this.email,
        required this.nni,
        required this.prenom,
        required this.dateDeNaissance,
        required this.nomPere,
        required this.telephone,
        required this.dateEnregistrement,
    });

    factory Citizen.fromJson(Map<String, dynamic> json) => Citizen(
        nom: json["nom"],
        postnom: json["postnom"],
        sexe: json["sexe"],
        lieuDeNaissance: json["lieu_de_naissance"],
        nomMere: json["nom_mere"],
        email: json["email"],
        nni: json["nni"],
        prenom: json["prenom"],
        dateDeNaissance: DateTime.parse(json["date_de_naissance"]),
        nomPere: json["nom_pere"],
        telephone: json["telephone"],
        dateEnregistrement: DateTime.parse(json["date_enregistrement"]),
    );

    Map<String, dynamic> toJson() => {
        "nom": nom,
        "postnom": postnom,
        "sexe": sexe,
        "lieu_de_naissance": lieuDeNaissance,
        "nom_mere": nomMere,
        "email": email,
        "nni": nni,
        "prenom": prenom,
        "date_de_naissance": "${dateDeNaissance.year.toString().padLeft(4, '0')}-${dateDeNaissance.month.toString().padLeft(2, '0')}-${dateDeNaissance.day.toString().padLeft(2, '0')}",
        "nom_pere": nomPere,
        "telephone": telephone,
        "date_enregistrement": dateEnregistrement.toIso8601String(),
    };
}

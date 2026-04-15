class OnipModel {
  final AdresseInfo? adresse;
  final PhotoInfo? photo_passeport;

  OnipModel({
    this.adresse,
    this.photo_passeport,
  });

  factory OnipModel.fromJson(Map<String, dynamic> json) {
    return OnipModel(
      adresse: json['adresse'] != null ? AdresseInfo.fromJson(json['adresse']) : null,
      photo_passeport: json['photo_passeport'] != null ? PhotoInfo.fromJson(json['photo_passeport']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adresse': adresse?.toJson(),
      'photo_passeport': photo_passeport?.toJson(),
    };
  }
}

class AdresseInfo {
  final String? province;
  final String? ville;
  final String? commune;
  final String? quartier;
  final String? avenue;
  final String? numero;
  final String? reference;

  AdresseInfo({
    this.province,
    this.ville,
    this.commune,
    this.quartier,
    this.avenue,
    this.numero,
    this.reference,
  });

  factory AdresseInfo.fromJson(Map<String, dynamic> json) {
    return AdresseInfo(
      province: json['province'],
      ville: json['ville'],
      commune: json['commune'],
      quartier: json['quartier'],
      avenue: json['avenue'],
      numero: json['numero'],
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'province': province,
      'ville': ville,
      'commune': commune,
      'quartier': quartier,
      'avenue': avenue,
      'numero': numero,
      'reference': reference,
    };
  }
}

class PhotoInfo {
  final String? url_photo;
  final String? date_prise;
  final String? format;

  PhotoInfo({
    this.url_photo,
    this.date_prise,
    this.format,
  });

  factory PhotoInfo.fromJson(Map<String, dynamic> json) {
    return PhotoInfo(
      url_photo: json['url_photo'],
      date_prise: json['date_prise'],
      format: json['format'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url_photo': url_photo,
      'date_prise': date_prise,
      'format': format,
    };
  }
}

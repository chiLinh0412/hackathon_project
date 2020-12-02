
import 'dart:core';



class Evenement {
  String identifiant;
  String ville;
  String adresse;
  String titre;
  String descriptionLongue;
  String descriptionCourt;
  String motCles;
  String image;
  String _dateTime;
  String horraire;
  String numeroTel;
  String lien_canonique;
  String siteWeb;
  List<dynamic> coordonneGeo;

  Evenement(
      String ville,
      String adresse,
      String titre,
      String descriptionLongue,
      String descritptionCourte,
      String motCles,
      String image,
      String _dateTime,
      String horraire,
      String numeroTel,
      String lien_canonique,
      String siteWeb,
      List<dynamic> coordonneGeo) {
    this.ville = ville;
    this.adresse = adresse;
    this.titre = titre;
    this.descriptionLongue = descriptionLongue;
    this.descriptionCourt = descritptionCourte;
    this.motCles = motCles;
    this.image = image;
    this._dateTime = _dateTime;
    this.horraire = horraire;
    this.numeroTel = numeroTel;
    this.lien_canonique = lien_canonique;
    this.siteWeb = siteWeb;
    this.coordonneGeo = coordonneGeo;
  }

  getCoordonneGeo(){
    return coordonneGeo;
  }
  Evenement.fromJson(Map<String, dynamic> json) {
    this.identifiant = json['identifiant'];
    this.ville = json['ville'];
    this.adresse = json['adresse'];
    this.titre = json['titre_fr'];
    this.descriptionLongue = json['description_longue_fr'];
    this.descriptionCourt  = json['description_fr'];
    this.motCles = json['mots_cles_fr'];
    this.image = json['image'];
    this._dateTime = json['dates'];
    this.horraire = json['horaires_detailles_fr'];
    this.numeroTel = json['telephone_du_lieu'];
    this.lien_canonique = json['lien_canonique'];
    this.siteWeb = json['site_web_du_lieu'];
    this.coordonneGeo = json['geolocalisation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifiant'] = this.identifiant;
    data['ville'] = this.ville;
    data['adresse'] = this.adresse;
    data['titre_fr'] = this.titre;
    data['description_longue_fr'] = this.descriptionLongue;
    data['description_fr'] = this.descriptionCourt;
    data['mots_cles_fr'] = this.motCles;
    data['image'] = this.image;
    data['dates'] = this._dateTime;
    data['horaires_detailles_fr'] = this.horraire;
    data['telephone_du_lieu'] = this.numeroTel;
    data['lien_canonique'] = this.lien_canonique;
    data['site_web_du_lieu'] = this.siteWeb;
    data['geolocalisation'] = this.coordonneGeo;
    return data;
  }
}

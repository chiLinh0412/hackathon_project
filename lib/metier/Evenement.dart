import 'dart:core';

import 'package:flutter/cupertino.dart';

class Evenement {
  int identifiant;
  String ville;

  String adresse;
  String titre;
  String description;
  String motCles;
  String image;
  DateTime _dateTime;
  String horraire;
  int numeroTel;
  String lien_canonique;
  String siteWeb;
  String coordonneGeo;

  Evenement(
      String ville,
      String adresse,
      String titre,
      String description,
      String motCles,
      String image,
      DateTime _dateTime,
      String horraire,
      int numeroTel,
      String lien_canonique,
      String siteWeb,
      String coordonneGeo) {
    this.ville = ville;
    this.adresse = adresse;
    this.titre = titre;
    this.description = description;
    this.motCles = motCles;
    this.image = image;
    this._dateTime = _dateTime;
    this.horraire = horraire;
    this.numeroTel = numeroTel;
    this.lien_canonique = lien_canonique;
    this.siteWeb = siteWeb;
    this.coordonneGeo = coordonneGeo;
  }


  Evenement.fromJson(Map<String, dynamic> json) {
    this.identifiant = json['identifiant'];
    this.ville = json['ville'];
    this.adresse = json['adresse'];
    this.titre = json['titre_fr'];
    this.description = json['description_longue_fr'];
    this.motCles = json['mots_cles_fr'];
    this.image = json['image'];
    this._dateTime = json['dates'];
    this.horraire = json['horaires_detailles_fr'];
    this.numeroTel = json['horaires_detailles_fr'];
    this.lien_canonique = json['horaires_detailles_fr'];
    this.siteWeb = json['horaires_detailles_fr'];
    this.coordonneGeo = json['horaires_detailles_fr'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifiant'] = this.identifiant;
    data['ville'] = this.ville;
    data['adresse'] = this.adresse;
    data['titre_fr'] = this.titre;
    data['description_longue_fr'] = this.description;
    data['mots_cles_fr'] = this.motCles;
    data['image'] = this.image;
    data['dates'] = this._dateTime;
    data['horaires_detailles_fr'] = this.horraire;
    data['Date'] = this.numeroTel;
    data['Date'] = this.lien_canonique;
    data['Date'] = this.siteWeb;
    data['Date'] = this.coordonneGeo;
    return data;
  }
}

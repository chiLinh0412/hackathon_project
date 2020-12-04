import 'package:cloud_firestore/cloud_firestore.dart';

class GlobaleService {
  static final CollectionReference Eventcollection =
      FirebaseFirestore.instance.collection("Evenements");

  static Stream<QuerySnapshot> get Evenementstream {
    return Eventcollection.limit(10).snapshots();
  }

  Stream<QuerySnapshot> streamRechercheEvenement(
      String critere, String valeurUser) {
    Stream<QuerySnapshot> retour;
    String crit = critere;

    switch (crit) {
      case "Titre":
        {
          if (valeurUser != null && valeurUser != "") {
            retour = Eventcollection.where('fields.titre_fr',
                    isGreaterThanOrEqualTo: valeurUser)
                .where('fields.titre_fr', isLessThan: valeurUser + 'z').limit(10)
                .snapshots();
          }else{
            retour = Evenementstream;
          }
          return retour;
        }
        break;

      case "Ville":
        {
          if (valeurUser != null && valeurUser != "") {
            retour = Eventcollection.where('fields.ville',
                    isGreaterThanOrEqualTo: valeurUser)
                .where('fields.ville', isLessThan: valeurUser + 'z').limit(10)
                .snapshots();
          }else{
            retour = Evenementstream;
          }
          return retour;
        }
        break;

      case "Thème":
        {
          if (valeurUser != null && valeurUser != "") {
            retour = Eventcollection.where('fields.thematiques',
                    isGreaterThanOrEqualTo: valeurUser)
                .where('fields.thematiques', isLessThan: valeurUser + 'z').limit(10)
                .snapshots();
          }else{
            retour = Evenementstream;
          }
          return retour;
        }
        break;

      case "Mot clés":
        {
          if (valeurUser != null && valeurUser != "") {
            retour = Eventcollection.where('fields.mots_cles_fr',
                    isGreaterThanOrEqualTo: valeurUser)
                .where('fields.mots_cles_fr', isLessThan: valeurUser + 'z').limit(10)
                .snapshots();
          }
          return retour;
        }
        break;

      case "Date":
        {
          if (valeurUser != null && valeurUser != "") {
            retour = Eventcollection.where('fields.date',
                    isGreaterThanOrEqualTo: valeurUser)
                .where('fields.date', isLessThan: valeurUser + 'z').limit(10)
                .snapshots();
          } else {
            retour = Evenementstream;
          }
          return retour;
        }
        break;
    }
  }
}

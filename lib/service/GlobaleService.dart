import 'package:cloud_firestore/cloud_firestore.dart';

class GlobaleService {
  static final CollectionReference Eventcollection =
      FirebaseFirestore.instance.collection("Evenements");

  static Stream<QuerySnapshot> get Evenementstream {
    return Eventcollection.orderBy("titre_fr", descending: true).limit(10).snapshots();
  }

  Stream<QuerySnapshot> streamRechercheEvenement(
      String critere, String valeurUser) {
    Stream<QuerySnapshot> retour;
    String crit = critere;

    switch (crit) {
      case "titre_fr":
        {
          if (valeurUser != null && valeurUser != "") {
            retour = Eventcollection.where('titre_fr',
                    isGreaterThanOrEqualTo: valeurUser)
                .where('titre_fr', isLessThan: valeurUser + 'z').limit(10)
                .snapshots();
          }
          return retour;
        }
        break;

      case "ville":
        {
          if (valeurUser != null && valeurUser != "") {
            retour = Eventcollection.where('ville',
                    isGreaterThanOrEqualTo: valeurUser)
                .where('ville', isLessThan: valeurUser + 'z').limit(10)
                .snapshots();
          }
          return retour;
        }
        break;

      case "themetique":
        {
          if (valeurUser != null && valeurUser != "") {
            retour = Eventcollection.where('thematiques',
                    isGreaterThanOrEqualTo: valeurUser)
                .where('thematiques', isLessThan: valeurUser + 'z').limit(10)
                .snapshots();
          }
          return retour;
        }
        break;

      case "Mot_cle":
        {
          if (valeurUser != null && valeurUser != "") {
            retour = Eventcollection.where('mots_cles_fr',
                    isGreaterThanOrEqualTo: valeurUser)
                .where('mots_cles_fr', isLessThan: valeurUser + 'z').limit(10)
                .snapshots();
          }
          return retour;
        }
        break;

      case "date":
        {
          if (valeurUser != null && valeurUser != "") {
            retour = Eventcollection.where('date',
                    isGreaterThanOrEqualTo: valeurUser)
                .where('date', isLessThan: valeurUser + 'z').limit(10)
                .snapshots();
          }
          return retour;
        }
        break;
    }
  }
}

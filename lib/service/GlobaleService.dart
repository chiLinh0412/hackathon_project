import 'package:cloud_firestore/cloud_firestore.dart';

class GlobaleService {
  String searchKey;
  static final CollectionReference Eventcollection =
      FirebaseFirestore.instance.collection("Evenements");

  static Stream<QuerySnapshot> get Evenementstream {
    return Eventcollection.orderBy("titre_fr", descending: true).snapshots();
  }

  Stream<QuerySnapshot> streamRechercheEvenement(String titreEvent,
      String nomVille, String nomTheme, String motcle, String date) {
    Stream<QuerySnapshot> retour;
    if (titreEvent != null && titreEvent != "") {
      retour =
          Eventcollection.where('titre_fr', isGreaterThanOrEqualTo: searchKey)
              .where('titre_fr', isLessThan: searchKey + 'z')
              .snapshots();
    }
    if (nomVille != null && nomVille != "") {
      retour = Eventcollection.where('ville', isGreaterThanOrEqualTo: searchKey)
          .where('ville', isLessThan: searchKey + 'z')
          .snapshots();
    }
    if (nomTheme != null && nomTheme != "") {
      retour = Eventcollection.where('thematiques',
              isGreaterThanOrEqualTo: searchKey)
          .where('thematiques', isLessThan: searchKey + 'z')
          .snapshots();
    }
    if (motcle != null && motcle != "") {
      retour = Eventcollection.where('mots_cles_fr',
              isGreaterThanOrEqualTo: searchKey)
          .where('mots_cles_fr', isLessThan: searchKey + 'z')
          .snapshots();
    }
    if (date != null && date != "") {
      retour = Eventcollection.where('dates', isGreaterThanOrEqualTo: searchKey)
          .where('dates', isLessThan: searchKey + 'z')
          .snapshots();
    }
    return retour;
  }
}

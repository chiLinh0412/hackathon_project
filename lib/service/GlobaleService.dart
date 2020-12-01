import 'package:cloud_firestore/cloud_firestore.dart';

class GlobaleService {
  static final CollectionReference Eventcollection =
      FirebaseFirestore.instance.collection("Evenements");

  static Stream<QuerySnapshot> get Evenementstream {
    return Eventcollection.orderBy("titre_fr", descending: true).snapshots();
  }

  Stream<QuerySnapshot> streamRechercheEvenement(String titreEvent,
      String nomVille, String nomTheme, String motcle, String date) {
    Stream<QuerySnapshot> retour;
    if (titreEvent != null && titreEvent != "") {
      retour = Eventcollection.where('titre_fr', isGreaterThanOrEqualTo: titreEvent)
              .where('titre_fr', isLessThan: titreEvent + 'z')
              .snapshots();
    }
    if (nomVille != null && nomVille != "") {
      retour = Eventcollection.where('ville', isGreaterThanOrEqualTo: nomVille)
          .where('ville', isLessThan: nomVille + 'z')
          .snapshots();
    }
    if (nomTheme != null && nomTheme != "") {
      retour = Eventcollection.where('thematiques',
              isGreaterThanOrEqualTo: nomTheme)
          .where('thematiques', isLessThan: nomTheme + 'z')
          .snapshots();
    }
    if (motcle != null && motcle != "") {
      retour = Eventcollection.where('mots_cles_fr',
              isGreaterThanOrEqualTo: motcle)
          .where('mots_cles_fr', isLessThan: motcle + 'z')
          .snapshots();
    }
    if (date != null && date != "") {
      retour = Eventcollection.where('dates', isGreaterThanOrEqualTo: date)
          .where('dates', isLessThan: date + 'z')
          .snapshots();
    }
    return retour;
  }
}

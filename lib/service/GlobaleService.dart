import 'package:cloud_firestore/cloud_firestore.dart';


class GlobaleService{
  static final CollectionReference Eventcollection = FirebaseFirestore.instance.collection("Evenement");
  static Stream<QuerySnapshot> get Evenementstream {
    return Eventcollection.orderBy("titre_fr", descending: true).snapshots();
  }
  static Future<QuerySnapshot> RechercheEvenement(String titreEvent) async {
    Eventcollection.where("titre_fr", isEqualTo: titreEvent ).snapshots();
  }
  static Future<DocumentReference> RechercheParLieu(String nomVille) async {
    Eventcollection.where("ville", isEqualTo: nomVille ).snapshots();

  }
  static Future<DocumentReference> RechercheParTheme(String nomTheme) async{
    Eventcollection.where("thematiques", isEqualTo: nomTheme ).snapshots();

  }
  static Future<DocumentReference> RechercheParMotCle(String motcle) async {
    Eventcollection.where("mots_cles_fr", isEqualTo: motcle ).snapshots();

  }
  static Future<DocumentReference> RechercheParDate(String date) async{
    Eventcollection.where("dates", isEqualTo: date ).snapshots();

  }
}
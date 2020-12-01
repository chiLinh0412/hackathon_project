import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlobaleService{
  static final CollectionReference Eventcollection = FirebaseFirestore.instance.collection("Evenement");
  static Stream<QuerySnapshot> get Evenementstream {
    return Eventcollection.orderBy("writtenDate", descending: true).snapshots();
  }
  static Future<QuerySnapshot> RechercheEvenement() {
    FirebaseFirestore.instance.collectionGroup("event").get();
  }
  static Future<DocumentReference> RechercheParLieu(String message) {
    FirebaseFirestore.instance.collectionGroup("event").get();

  }
  static Future<DocumentReference> RechercheParTheme(String message) {
    FirebaseFirestore.instance.collectionGroup("event").get();

  }
  static Future<DocumentReference> RechercheParDate(String message) {
    FirebaseFirestore.instance.collectionGroup("event").get();

  }
}
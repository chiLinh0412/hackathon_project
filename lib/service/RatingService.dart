import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/service/Auth.dart';

class RatingService {
  static final CollectionReference RatingCollection =
      FirebaseFirestore.instance.collection("Rating");

  static Stream<QuerySnapshot> get Ratingstream {
    return RatingCollection.snapshots();
  }

  Future<double> postRating(
      String event_id, String user_email, double rating) async {
    DocumentReference ref = RatingCollection.doc(event_id + user_email);
    ref.delete();
    ref.set({'id_event': event_id, 'id_user': user_email, 'note': rating});

    return getAverageRating(event_id);
  }

  Future<double> getAverageRating(String id_event) async {
    double add = 0;
    int count = 0;
    await RatingCollection.where('id_event', isEqualTo: id_event)
        .getDocuments()
        .then((value) => {
              value.docs.forEach((element) {
                add += element.data()['note'] as double;
                count++;
              })
            });

    return count == 0 ? 0 : add / count;
  }

  Future<double> getRatingForUser(String id_event, id_user) async {
    double ret = await RatingCollection.where('id_event', isEqualTo: id_event)
        .where('id_user', isEqualTo: id_user)
        .snapshots()
        .forEach((element) {
      element.docs.forEach((doc) => doc['note']);
    });

    print(ret);
    return ret == null ? 0 : ret;
  }
}

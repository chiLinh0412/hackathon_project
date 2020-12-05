import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackathon_project/service/Auth.dart';

class OwnershipService {
  static final CollectionReference OwnerCollection =
  FirebaseFirestore.instance.collection("Owners");

  static Stream<QuerySnapshot> get OwnerStream {
    return OwnerCollection.snapshots();
  }

  Future<String> getEventOwner(String id) async {
    String ret;
    try {
      await OwnerCollection.doc(id).get().then((value) =>
      {
        ret = value.data()['user_id']
      });
    } catch (e)
    {

    }
    print(ret);
    return ret;
  }

  void updateFilling(String id, int value) async{
    try{
      Map<String, dynamic> a;
      await OwnerCollection.doc(id).get().then( (doc) =>
        {
          a = doc.data()
        }
      );
      a['fill'] = value;
      await OwnerCollection.doc(id).update(a);
    }catch(e)
    {

    }
  }

  Future<int> getFilling(String id) async {
    int ret;
    try {
      await OwnerCollection.doc(id).get().then((value) =>
      {
        ret = value.data()['fill']
      });
    } catch (e)
    {

    }
    return ret;
  }

  Future<int> getMaxFilling(String id) async {
    int ret;
    try {
      await OwnerCollection.doc(id).get().then((value) =>
      {
        ret = value.data()['max']
      });
    } catch (e)
    {

    }

    return ret;
  }
}

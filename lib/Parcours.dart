import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/LeftMenu.dart';
import 'package:hackathon_project/metier/Evenement.dart';
import 'package:hackathon_project/service/GlobaleService.dart';

import 'main.dart';

class Parcours extends StatefulWidget {
  @override
  _Parcours createState() => _Parcours();
}

class _Parcours extends State<Parcours> {

  String mail = FirebaseAuth.instance.currentUser.email;
  FirebaseFirestore db = FirebaseFirestore.instance;

  //Stream<QuerySnapshot> listParcours = GlobaleService.Evenementstream ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parcours"),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('parcours').where('id_user', isEqualTo: mail).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:

              return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  var i = document['titre'];
                  return new Column(
                    children: <Widget> [
                      Container(
                        child: Text(i[0]),
                      ),
                      Container(
                        child: Text(i[1]),
                      ),
                      Container(
                        child: Text(i[2]),
                      ),
                      Container(
                        child: Text(i[3]),
                      ),Container(
                        child: Text(i[4]),
                      ),
                    ],

                    //subtitle: new Text(document['id_event']),
                  );
                }).toList(),
              );
            };
        },
      ),
      drawer: LeftMenu(),
    );

}

}

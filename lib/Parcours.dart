
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
          print(snapshot);
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:

              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot titre = snapshot.data.documents[index];
                  return new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      for (var item in titre["titre"])
                        Container(
                          child: Card(
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(color: Colors.blue, width: 4.0),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  contentPadding: EdgeInsets.all(8.0),
                                  title: Text(item),


                                ),
                              ],
                            ),

                          ),
                        )
                      ]

                  );
                },

              );
          };
        },
      ),
      drawer: LeftMenu(),
    );

  }

}

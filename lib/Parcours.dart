import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/service/GlobaleService.dart';

import 'main.dart';

class Parcours extends StatefulWidget {
  @override
  _Parcours createState() => _Parcours();
}

class _Parcours extends State<Parcours> {
  List<String> evenement = ["hi", "hello", "gooooo"];
  //Stream<QuerySnapshot> listParcours = GlobaleService.Evenementstream ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parcours"),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, position) {
          return Card(
            child: Text(evenement[position]),
          );
        },
        itemCount: evenement.length,
      ),
    );
  }



}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/metier/Evenement.dart';
import 'package:hackathon_project/service/Auth.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import '../main.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  final Auth _auth = Auth();
  final _keyForm = GlobalKey<FormState>();
  String email = '';
  String password = '';


  //Widget loadingWidget = Loading();
  bool loading = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    //if (null != Provider.of<User>(context)) {
    //  return MyApp();
    //}

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Register"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Form(
            key: _keyForm,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                  validator: (val) => val.isEmpty ? 'Entrez votre email' : null,
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (val) => val.length < 6
                      ? 'Entrez un mot de passe de 6 caractéres ou plus'
                      : null,
                  onChanged: (val) => password = val,
                ),
                SizedBox(height: 10.0),

                Text(error, style: TextStyle(color:Colors.red),),
                FlatButton(
                  onPressed: () {
                    register();
                  },
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.yellowAccent,
                  child: Text('Inscription'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void register() async {
    if (_keyForm.currentState.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await _auth
            .registerEmail(email, password);
        setState(() {
          loading = false;
          ajouterUser();
        }
        );
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          loading = false;
          error = e.toString();
        });
      }
    }
  }

  void ajouterUser(){
    FirebaseFirestore.instance.collection("parcours").doc(email).set({
      'id_user' : email,
      'titre' : '',
    });

  }


}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/coloredIconText.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hackathon_project/connectionUser/Login.dart';
import 'package:hackathon_project/main.dart';
import 'package:hackathon_project/metier/Evenement.dart';
import 'package:hackathon_project/service/Auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LeftMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Drawer(
        child: Container(
            decoration: BoxDecoration(),
            child: Column(children: [
              user == null
                  ? FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text('Connexion'))
                  : FlatButton(
                      onPressed: () => Auth().signOut(),
                      child: Text('Deconnexion')),
              FlatButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp())),
                  child: Text('Accueil')),
              if (user != null)
                FlatButton(onPressed: null, child: Text('Mes parcours'))
            ])));
  }
}

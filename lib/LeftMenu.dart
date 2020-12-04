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

import 'Parcours.dart';

class LeftMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Drawer(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.white])),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  user == null
                      ? FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8.0),
                            leading: Icon(Icons.login),
                            title: Text("Connexion"),
                          ),
                        )
                      : FlatButton(
                          onPressed: () => Auth().signOut(),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8.0),
                            title: Text('Deconnexion'),
                            leading: Icon(Icons.exit_to_app),
                          )),
                  FlatButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp())),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      leading: Icon(Icons.home),
                      title: Text("Accueil"),
                    ),
                  ),
                  if (user != null)
                    FlatButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Parcours())),
                        child:ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          title:Text('Mes parcours'),
                          leading: Icon(Icons.not_listed_location_sharp),
                        )),
                  FlatButton(
                      onPressed: null,
                      //=> Navigator.push(context,
                      // MaterialPageRoute(builder: (context) => CarteInteractive())
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        leading: Icon(Icons.map_outlined),
                        title: Text('Carte interactive'),
                      )),
                  FlatButton(
                      onPressed: _launchLink,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text('Lien Carte interactive '),
                        leading: Icon(Icons.map),
                      ),),
                ])));
  }

  void _launchLink() async {
    const url =
        "https://www.data.gouv.fr/en/reuses/carte-interactive-fete-de-la-science-2019/";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Impossible de lancer le lien.";
    }
  }
}

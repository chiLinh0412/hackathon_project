import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/LeftMenu.dart';
import 'package:hackathon_project/coloredIconText.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hackathon_project/metier/Evenement.dart';
import 'package:hackathon_project/service/Auth.dart';
import 'package:hackathon_project/service/OwnershipService.dart';
import 'package:hackathon_project/service/RatingService.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class IndividualEventPage extends StatefulWidget {
  //todo @required this.event
  IndividualEventPage({Key key, this.event}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //todo need un event
  final Evenement event;

  @override
  _IndividualEventPage createState() => _IndividualEventPage();
}

class _IndividualEventPage extends State<IndividualEventPage> {
  void _addToParcours() {
    String email = FirebaseAuth.instance.currentUser.email;
    //String idCurrant =  FirebaseFirestore.instance.collection("parcours").doc(email).get("id_courrant").toString();
    FirebaseFirestore.instance
        .collection("parcours")
        .doc(email).updateData({"titre": FieldValue.arrayUnion([widget.event.titre])});
  }

  void _onUpdateRating(double d) async {
    await RatingService()
        .postRating(widget.event.identifiant,
        Provider.of<User>(context, listen: false).email, d)
        .then((value) => {
      setState(() {
        _rating = d;
        _avg_rating = value;
      })
    });
  }

  double _rating = -1;
  double _avg_rating = -1;

  int fill;
  int max;

  int updateValue;

  bool isOwner = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    loadState(user);
    return Scaffold(
      appBar: AppBar(
        //todo : Récupérer le nom de l'event
        title: Text(widget.event.titre),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //todo : Récupérer l'url de l'image
              if (widget.event.image != null) Image.network(widget.event.image),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .59,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.adresse + ", " + widget.event.ville,
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Text("HORRAIRE: " + widget.event.horraire,
                          style: TextStyle(
                              color:Colors.grey,
                              fontWeight: FontWeight.bold
                          ),),
                        SizedBox(height: 10.0),
                        Text(
                          "ORGANISTEUR",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .39,
                    child: Column(
                      children: [
                        //TODO : gérer si l'utilisateur est connecté ou non
                        // pour pouvoir noté

                        RatingBar(
                          itemCount: 5,
                          onRatingUpdate: _onUpdateRating,
                          allowHalfRating: true,
                          direction: Axis.horizontal,
                          ratingWidget: RatingWidget(
                              full: Icon(Icons.star, color: Colors.amber),
                              half: Icon(Icons.star_half, color: Colors.amber),
                              empty:
                              Icon(Icons.star_border, color: Colors.amber)),
                          itemSize: 30,
                          //todo
                          ignoreGestures: user == null,
                          initialRating: _rating,
                        ),
                        Center(
                          child: Text(
                            _avg_rating.toString() + "/5",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Text(widget.event.descriptionLongue),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //todo les ifs
                  Container(
                    child: Row(
                      children: [
                        if (widget.event.numeroTel != null)
                          ColoredIconText(
                            text: "APPELLER",
                            icon: Icons.phone,
                            onPressed: () {
                              launch(('tel://${widget.event.numeroTel}'));
                            },
                          ),
                        if (widget.event.lien_canonique != null)
                          ColoredIconText(
                            text: "WEB",
                            icon: Icons.description,
                            onPressed: () {
                              launch((widget.event.siteWeb));
                            },
                          )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Places: "),
                  isOwner
                      ? Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Disponible',
                            border: OutlineInputBorder()),
                        initialValue: fill.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (int.parse(value) <= max)
                            setState(() {
                              updateValue = int.parse(value);
                            });
                        },
                      ))
                      : Text(fill.toString()),
                  Text(" / " + max.toString()),
                  if (isOwner)
                    FlatButton(
                        onPressed: updateEventAttendance, child: Text("Update"))
                ],
              )
            ],
          ),
        ),
      ),
      //TODO : gérer si l'utilisateur est connecté ou non
      floatingActionButton: user != null
          ? FloatingActionButton(
        onPressed: _addToParcours,
        tooltip: 'Ajouter au parcours',
        child: Icon(Icons.add),
      )
          : null,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void loadState(User user) {
    RatingService().getAverageRating(widget.event.identifiant).then((value) => {
      this.setState(() {
        _avg_rating = value;
      })
    });

    if (user != null) {
      RatingService()
          .getRatingForUser(widget.event.identifiant, user.email)
          .then((value) => {
        this.setState(() {
          _rating = value;
        })
      });

      OwnershipService()
          .getEventOwner(widget.event.identifiant)
          .then((value) => {
        this.setState(() {
          isOwner = value == user.email;
        })
      });
    }

    OwnershipService().getFilling(widget.event.identifiant).then((value) => {
      this.setState(() {
        fill = value;
      })
    });

    OwnershipService().getMaxFilling(widget.event.identifiant).then((value) => {
      this.setState(() {
        max = value;
      })
    });
  }

  void updateEventAttendance() {
    if(updateValue != null && updateValue <= max)
      OwnershipService().updateFilling(widget.event.identifiant, updateValue);
  }
}

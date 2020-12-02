import 'package:flutter/material.dart';
import 'package:hackathon_project/coloredIconText.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hackathon_project/metier/Evenement.dart';
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

  }

  void _onUpdateRating(double d){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //todo : Récupérer le nom de l'event
        title: Text(widget.event.titre),
      ),
      body: Container(
        padding: EdgeInsets.all(3),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //todo : Récupérer l'url de l'image
            Image.network(widget.event.image),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*.59,
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.event.adresse+ ", " + widget.event.ville,
                        style: TextStyle(
                            color:Colors.grey,
                            fontWeight: FontWeight.bold
                        ),),
                      Text("ORGANISTEUR",
                        style: TextStyle(
                            color:Colors.grey,
                          fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*.39,
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
                            full: Icon(Icons.star, color:Colors.amber),
                            half: Icon(Icons.star_half, color:Colors.amber),
                            empty: Icon(Icons.star_border, color:Colors.amber)
                        ),
                        itemSize: 30,
                        //todo
                        ignoreGestures: false,

                      ),
                      Center(
                        child:
                        Text("NOTE/5",
                          style: TextStyle(
                              color:Colors.grey
                          ),),
                      )
                    ],
                  ),
                )
              ],
            ),
            Text(widget.event.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //todo les ifs
                Container(
                  child: Row(
                    children: [
                      if(widget.event.numeroTel.isNotEmpty)
                        ColoredIconText(text:"APPELLER", icon:Icons.phone, onPressed: (){
                          launch(('tel://${widget.event.numeroTel}'));
                        },),
                      if(widget.event.lien_canonique.isNotEmpty)
                        ColoredIconText(text:"WEB", icon: Icons.description,
                        onPressed: (){
                          launch((widget.event.siteWeb));
                        },)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      //TODO : gérer si l'utilisateur est connecté ou non
      floatingActionButton: FloatingActionButton(
        onPressed: _addToParcours,
        tooltip: 'Ajouter au parcours',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
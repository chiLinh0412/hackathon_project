import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/service/Auth.dart';
import 'package:hackathon_project/service/GlobaleService.dart';
import 'package:provider/provider.dart';

import 'metier/Evenement.dart';
import 'individual.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Auth().user,
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       home: MyHomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobaleService globaleService = new GlobaleService();

  String _selection;
  String _recherche;

  final myController = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),

      body: Container (

        child :


        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children : [
            Padding(
              padding: EdgeInsets.all(16.0),
              child:
              Row  (
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  select(),

                  Expanded(
                    child : TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recherche',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    tooltip: 'Filtre',
                    onPressed: () {
                      setState(() {
                        _recherche = myController.text;
                      });
                    },
                  ),


                ],),
            ),
            Text("Verification ---> Filtrage par $_selection, La valeur $_recherche ",
                style : TextStyle(color: Colors.black,
                    fontSize: 20 )),
            Expanded(
              child : buildStreamListView(context),
            ),],
        ),
      ),
    );
  }



  Widget select() {
    return DropdownButton<String>(
      value: _selection,
      icon: Icon(Icons.arrow_downward),
      iconSize: 20,
      elevation: 16,
      style: TextStyle(color: Colors.black,
          fontSize: 20 ),
      underline: Container(
        height: 2,
        decoration: new BoxDecoration(
            borderRadius:BorderRadius.all(Radius.circular(2.0)),
            border: new Border.all(color: Colors.black38)
        ),
      ),
      onChanged: (String newValue) {
        setState(() {
          _selection = newValue;
        });
      },
      items: <String>['Mot clés','Lieu','Thème','Date']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child : Text(value),
        );
      }).toList(),
    );
  }

  Widget buildStreamListView(BuildContext context) {

    return StreamBuilder(

      stream: FirebaseFirestore.instance.collection("Evenements").limit(5).snapshots(),
      builder: (context, snapshot)  {

        if(snapshot.hasError){
          return Center(
            child: Text("ERROR ${snapshot.error}"),
          );
        }

        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }


        return ListView(
            children: snapshot.data.documents.map<Widget>((DocumentSnapshot document) {

              Evenement event = Evenement.fromJson(document.data()['fields']);

              return
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
                        leading: Image.network(event.image.toString()),
                        title: Text(event.titre.toString()+" à "+event.ville.toString()),
                        subtitle: Text(event.descriptionCourt.toString()),
                        onTap: ()=> {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:
                                    (context) => IndividualEventPage(event: event),
                            ),
                          )
                        },

                       ),
                    ],
                  ),

                  ),
                );

            }).toList() // end of map

        );

      },
    );
  }

}
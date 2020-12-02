import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon_project/service/Auth.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final Auth _auth = Auth();
  String email = '';
  String password = '';
  bool loading = false;
  String error = "";

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (null != Provider.of<User>(context)) {
      return MyApp();
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Login"),
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
                  validator: (val) =>
                      val.isEmpty ? 'Entrez une adresse mail' : null,
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
                Text(error, style: TextStyle(color: Colors.red)),
                FlatButton(
                  onPressed: () {
                    connexion();
                  },
                  color: Colors.yellowAccent,
                  child: Text('Connexion'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(height: 30.0),
                OutlineButton(
                  onPressed: () {},
                  borderSide: BorderSide(width: 1.0, color: Colors.black),
                  child: Text('Mot de passe oublié'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(height: 5.0),
                OutlineButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  borderSide: BorderSide(width: 1.0, color: Colors.black),
                  child: Text('Pas de compte, Inscrivez vous ?'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void connexion() async {
    if (_keyForm.currentState.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await _auth.signInEmail(email, password).then((value) => {
              Navigator.pop(
                  context)
            });
        setState(() {
          loading = false;
        });
      } catch (e) {
        setState(() {
          print('ERROR');
          loading = false;
          error = e.toString();
        });
      }
    }
  }
}

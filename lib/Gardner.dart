import 'package:enersuryadmin/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gardner extends StatefulWidget {
  @override
  _GardnerState createState() => _GardnerState();
}

class _GardnerState extends State<Gardner> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return WillPopScope(
              onWillPop: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen1()),
          );

          return new Future(() => false);
        },
          child: Scaffold(
        appBar: AppBar(
          actions: [FlatButton(onPressed: () {


            _auth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen1()),
              );
          }, child: Text("Logout"))],
        ),
        body: Container(child: Center(child: Text("Gardner"))),
      ),
    );
  }
}

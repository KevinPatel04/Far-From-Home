import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_image_picker/src/asset.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(FarFromHome());

class FarFromHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[700],
        brightness: Brightness.light,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
            label: Text('Skip'),
            icon: Icon(Icons.close),
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Close",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                'Redefining Your Home',
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Color(0x991976d2),
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                'Search Experience',
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Color(0x991976d2),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Image.asset(
                'assets/landing_page.png',
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: RaisedButton(
                  child: Text('CREATE FREE ACCOUNT'),
                  color: Colors.blue[700],
                  textColor: Colors.white,
                  elevation: 5,
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50),
                  ),
                  onPressed: (){
                    Fluttertoast.showToast(
                        msg: "This is Create Account Toast",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,5,0,10),
                child: RaisedButton(
                  child: Text('SIGN IN'),
                  color: Colors.white,
                  textColor: Colors.blue[700],
                  elevation: 5,                
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 85.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50),
                  ),
                  onPressed: (){
                    Fluttertoast.showToast(
                        msg: "This is Sign In Toast",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

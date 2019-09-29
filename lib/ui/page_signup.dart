import 'package:flutter/material.dart';
import 'package:farfromhome/ui/first_screen.dart';
import 'package:farfromhome/ui/page_home.dart';
import 'package:farfromhome/ui/page_login.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:farfromhome/widgets/widgets.dart';
import 'package:farfromhome/ui/auth_design.dart';

// SIGNUP STARTS HERE
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Screen size;
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () { 
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
              },
              //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Center(
          child:  Text(
              "Far From Home",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: size.hp(3)
              ),
            ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper2(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: size.hp(11),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0x221976d2), Color(0x221976d2)])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper3(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: size.hp(11),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0x441976d2), Color(0x441976d2)])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper1(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      
                    ],
                  ),
                  width: double.infinity,
                  height: size.hp(11),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff1976d2), Color(0xff1976d2)])),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.hp(2),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.wp(6)),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                onChanged: (String value) {},
                cursorColor: Colors.blue[900],
                decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.email,
                        color: Colors.blue[700],
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: size.wp(2.5), vertical: size.hp(2))),
              ),
            ),
          ),
          SizedBox(
            height: size.hp(2),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.hp(3)),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                onChanged: (String value) {},
                cursorColor: Colors.blue[800],
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: Colors.blue[700],
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: size.wp(2.5), vertical: size.hp(2))),
              ),
            ),
          ),
          SizedBox(
            height: size.hp(3),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: size.wp(6)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Color(0xff1976d2)),
                child: FlatButton(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: size.hp(3)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                ),
              )),
          SizedBox(
            height: size.hp(5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Already Registered ? ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.hp(2),
                    fontWeight: FontWeight.normal),
              ),
              FlatButton(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                      fontSize: size.hp(2),
                      decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
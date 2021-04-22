import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:farfromhome/ui/page_home.dart';
import 'package:farfromhome/ui/page_login.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:farfromhome/widgets/auth_design.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:farfromhome/LocalBindings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

// SIGNUP STARTS HERE
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _phoneNo;
  String _fname;
  String _lname;
  String _confirmPassword;
  String _uid;
  Screen size;

  final DocumentReference documentReference =
  FirebaseFirestore.instance.collection("User").doc();

    // adding data to fire store

  void _add() {
    Map<String, dynamic> data = <String, dynamic>{
      "firstName": _fname,
      "lastName": _lname,
      "mobileNo": _phoneNo,
      "email": _email,
      "uid" : _uid,
      "status" : true,
      "Date Created" : DateTime.now(),
    };
    documentReference.set(data).whenComplete(() {
      print("Data added");
    }).catchError((e) => print(e));
  }
  bool validateAndSave() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if(validateAndSave()){
      try{
        UserCredential user= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        print("signed in  ${user.user.uid}");
        _uid = user.user.uid;
        try {
          LocalStorage.sharedInstance
            .setAuthStatus(key: Constants.isLoggedIn, value: "true");
        } catch (e) {
          print("An error occured while trying to send email verification");
        }
        _add();
        FirebaseFirestore.instance.collection('User').where('uid', isEqualTo: _uid)
          .snapshots().listen(
                (data) {
                  print('Docfound :  ${data.docs[0].id}');
                  LocalStorage.sharedInstance.setUserRef(key: Constants.userRef,value: data.docs[0].id);
                }
        );
        Fluttertoast.showToast(msg: "Account Resgistered Successfully");
        FirebaseFirestore.instance.collection('User').where('uid', isEqualTo: user.user.uid)
          .snapshots().listen(
                (data) {
                  print('Docfound :  ${data.docs[0].id}');
                  LocalStorage.sharedInstance.setUserRef(key: Constants.userRef,value: data.docs[0].id.toString());
                }
          );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SearchPage()));


      }
      catch(e){
        //print("error : $e");
        Fluttertoast.showToast(msg: e.code);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue[700].withOpacity(1));
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: WaveClipper2(),
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: size.hp(20),
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
                    height: size.hp(20),
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
                         Center(
                            child:Container(
                              padding: EdgeInsets.only(top: size.getWidthPx(10)),
                              child: Text(
                                "Far From Home",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.getWidthPx(30)
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    width: double.infinity,
                    height: size.hp(20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff1976d2), Color(0xff1976d2)])),
                  ),
                ),
                Positioned(
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () { 
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage()));
                    },
                    //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                  child: TextFormField(
                    cursorColor: Colors.blue[900],
                    decoration: InputDecoration(
                        hintText: "First Name",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.person,
                            color: Colors.blue[700],
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: size.wp(2.5), vertical: size.hp(2))
                    ),
                    validator: (value)=> value.isEmpty?"First Name can't be empty":null,
                    onSaved: (value) => _fname=value,
                  ),
                ),
              ),
              SizedBox(
                height: size.hp(2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.wp(6)),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    cursorColor: Colors.blue[900],
                    decoration: InputDecoration(
                        hintText: "Last Name",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.person,
                            color: Colors.blue[700],
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: size.wp(2.5), vertical: size.hp(2))
                    ),
                    validator: (value)=> value.isEmpty?"Last Name can't be empty":null,
                    onSaved: (value) => _lname=value,
                  ),
                ),
              ),
              SizedBox(
                height: size.hp(2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.wp(6)),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.blue[900],
                    decoration: InputDecoration(
                        hintText: "Mobile Number",
                        prefixText: "+91",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.phone_android,
                            color: Colors.blue[700],
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: size.wp(2.5), vertical: size.hp(2))
                    ),
                    validator: (value)=> value.isEmpty?"Mobile Number can't be empty":null,
                    onSaved: (value) => _phoneNo = "+91" + value,
                  ),
                ),
              ),
              SizedBox(
                height: size.hp(2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.wp(6)),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
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
                            horizontal: size.wp(2.5), vertical: size.hp(2))
                    ),
                    validator: (value)=> value.isEmpty?"Email can't be empty":null,
                    onSaved: (value) => _email=value,
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
                  child: TextFormField(
                    obscureText: true,
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
                            horizontal: size.wp(2.5), vertical: size.hp(2))
                    ),
                    validator: (value)=>value.isEmpty?"Password can't be empty":null,
                    onSaved: (value) => _password=value,
                  ),
                ),
              ),
              SizedBox(
                height: size.hp(3),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.hp(3)),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextFormField(
                    obscureText: true,
                    cursorColor: Colors.blue[800],
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
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
                            horizontal: size.wp(2.5), vertical: size.hp(2))
                    ),
                    validator: (value)=>value.isEmpty?"Confirm Password can't be empty":null,
                    onSaved: (value) => _password=value,
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
                      onPressed: validateAndSubmit,
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
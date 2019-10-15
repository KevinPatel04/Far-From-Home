import 'package:farfromhome/LocalBindings.dart';
import 'package:farfromhome/ui/about_developers.dart';
import 'package:farfromhome/ui/first_screen.dart';
import 'package:farfromhome/ui/page_add_house.dart';
import 'package:farfromhome/ui/page_custom_search.dart';
import 'package:farfromhome/ui/page_login.dart';
import 'package:farfromhome/ui/page_profile.dart';
import 'package:farfromhome/ui/page_splash.dart';
import 'package:farfromhome/ui/page_users.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget drawer(img,context,_imageUrl,_name,_email,logStatus,docRef){
  //String logStatus = LocalStorage.sharedInstance.loadAuthStatus(Constants.isLoggedIn).toString();
  Screen size = Screen(MediaQuery.of(context).size);
  return Drawer(
    child: ListView(
      padding: EdgeInsets.all(0),
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: size.hp(100),
                ),
                Positioned(
                  right: 5,
                  top: 0,
                  child: logStatus == "true" && _imageUrl!=null ? userProfile(_imageUrl,true) : userProfile(_imageUrl,false),
                ),
                Positioned(
                  left: 5,
                  bottom: 27,
                  child: Text(
                    _name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                ),
                Positioned(
                  left: 5,
                  bottom: 10,
                  child: Text(
                    _email,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              // image: DecorationImage(
              //   image: img.image,
              //   fit: BoxFit.fill,
              // ),
              color: colorCurve,
            ),
          ),

          // Search Property
          ListTile(
            title: Text(
                "Search Property",
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.searchLocation,
                  size: 20,
                  color: Colors.deepOrangeAccent,
                );
              },
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => CustomSearchPage()));
              // _uri
            },
          ),

          // Post Ad
          ListTile(
            title: Text(
                "Post Free House Ad",
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.home,
                  size: 20,
                  color: Colors.blue[700],
                );
              },
            ),
            onTap: () {
              Navigator.pop(context);
              if(logStatus == "false"){
                Fluttertoast.showToast(msg: 'Login / Signup is required');
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FirstScreen()));
              }else{
                Navigator.push(context,MaterialPageRoute(builder: (_)=>AddHouse(docRef)));
              }
              // _uri
            },
          ),

          // My Favrourites
          ListTile(
            title: Text(
                "My Favrouites",
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.solidHeart,
                  size: 20,
                  color: Colors.red,
                );
              },
            ),
            onTap: () {
              Navigator.pop(context);
              if(logStatus == "false"){
                Fluttertoast.showToast(msg: 'Login / Signup is required');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FirstScreen()));
              }else{
                Fluttertoast.showToast(msg: 'Redirected to Fovroites Page');
              }
              // _uri
            },
          ),
          
          // Pay Rents
          ListTile(
            title: Text(
                'Pay Your Rents',
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.wallet,
                  size: 20,
                  color: Colors.green,
                );
              },
            ),
            onTap: () {
              Navigator.pop(context);
              if(logStatus == "false"){
                Fluttertoast.showToast(msg: 'Login / Signup is required');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FirstScreen()));
              }else{
                Navigator.push(context,MaterialPageRoute(builder: (_) => Users()));
              // _uri
              }
            },
          ),

          // Pay Rents
          ListTile(
            title: Text(
                'Contact Users',
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.users,
                  size: 20,
                  color: Colors.deepPurpleAccent,
                );
              },
            ),
            onTap: () {
              Navigator.pop(context);
              if(logStatus == "false"){
                Fluttertoast.showToast(msg: 'Login / Signup is required');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FirstScreen()));
              }else{
                Navigator.push(context,MaterialPageRoute(builder: (_) => Users()));
              // _uri
              }
            },
          ),
          new Divider(color: Colors.black26),
          // Profile
          if(logStatus == "true")
          ListTile(
            title: Text(
                'Manage Profile',
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.userAlt,
                  size: 20,
                  color: Colors.grey,
                );
              },
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (_) => ProfilePage(docRef,false)));
              // _uri
            },
          ),

          // Item About Developer
          ListTile(
            title: Text(
                'About Developers',
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.code,
                  size: 20,
                  color: Colors.grey,
                );
              },
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (_)=> AboutDevelopers()));
              // _uri
            },
          ),

          // Item Logout
          ListTile(
            title: Text(
                logStatus == "true" ? 'Log-Out' : 'Log-In',
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  logStatus =="true" ?FontAwesomeIcons.signOutAlt:FontAwesomeIcons.signInAlt,
                  size: 20,
                  color: Colors.grey,
                );
              },
            ),
            onTap: logStatus == "true"
            ? () async{
              print("Logout Pressed");
              try {
                await FirebaseAuth.instance.signOut();
                LocalStorage.sharedInstance.setAuthStatus(key:Constants.isLoggedIn,value: "false");
                LocalStorage.sharedInstance.setUserRef(key:Constants.userRef,value: "NULL");
              } catch (e) {
                print(e);
              }
              LocalStorage.sharedInstance.setUserRef(key: Constants.userRef,value: null);
              Navigator.pushReplacement(context,MaterialPageRoute(builder:(_) =>  SplashScreen()));
            }
            : () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
          ),
        ],
      ),
    );
}

Widget userProfile(_imagePath,val){
    return Container(
          child: ClipRRect(
            borderRadius: new BorderRadius.all(Radius.circular(43)),
            child: Container(
              color: Colors.white,
              padding: new EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                child: val
                ? Image.network(
                  _imagePath,
                  height: 70,
                  width: 70,
                )
                : Image.asset(
                  'assets/icons/avatar.png',
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          ),
    );
}
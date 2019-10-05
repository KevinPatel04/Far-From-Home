import 'package:farfromhome/ui/about_developers.dart';
import 'package:farfromhome/ui/page_login.dart';
import 'package:farfromhome/ui/page_users.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget drawer(img,context,_imageUrl,_name,_email){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.all(0),
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 13,
                  bottom: 40,
                  child: userProfile(_imageUrl),
                ),
                Positioned(
                  left: 5,
                  top:25,
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
                  top:50,
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
              image: DecorationImage(
                image: img.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          
          // Item 1
          ListTile(
            title: Text(
                "Home",
                style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.home,
                  size: 20,
                );
              },
            ),
            onTap: () {
              Navigator.pop(context);
              // _uri
            },
          ),

          // Item 2
          ListTile(
            title: Text(
                'Pay Rents',
                style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.database,
                  size: 20,
                );
              },
            ),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (_) => Users()));
              // _uri
            },
          ),

          // Item About Developer
          ListTile(
            title: Text(
                'About Developers',
                style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.code,
                  size: 20,
                );
              },
            ),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (_)=> AboutDevelopers()));
              // _uri
            },
          ),

          // Item Logout
          ListTile(
            title: Text(
                'Log Out',
                style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 20,
                );
              },
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginPage()));
              // _uri
            },
          ),

        ],
      ),
    );
}

Widget userProfile(_imagePath){
    return Container(
          child: ClipRRect(
            borderRadius: new BorderRadius.all(Radius.circular(43)),
            child: Container(
              color: Colors.white,
              padding: new EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                child: Image.asset(
                  _imagePath,    
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          ),
    );
}
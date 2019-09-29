import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:farfromhome/ui/page_home.dart';
import 'package:farfromhome/ui/page_login.dart';
import 'package:farfromhome/ui/page_signup.dart';
import 'package:farfromhome/utils/responsive_screen.dart';

class FirstScreen extends StatelessWidget {
  Screen size;
  @override
  Widget build(BuildContext context) {
    
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
            label: Text('Skip'),
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage()));
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
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
                  padding: EdgeInsets.symmetric(vertical: size.getWidthPx(8), horizontal: size.getWidthPx(70)),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50),
                  ),
                  onPressed: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
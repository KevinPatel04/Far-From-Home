import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AboutDevelopers extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        title: Text('About Developers'),
        backgroundColor: Colors.blue[700],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ResponsiveContainer(
                  widthPercent: 72,
                  heightPercent: 43,
                  child: Container(
                    child: Card(
                      elevation: 6,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                              child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          ResponsiveContainer(
                                            heightPercent: 40,
                                            widthPercent: 72,
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperTwo(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.9),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.17,
                                            ),
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperOne(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.3),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.18,
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.07,
                                            left: MediaQuery.of(context).size.width*0.20,
                                            child: ClipRRect(
                                              borderRadius: new BorderRadius.all(Radius.circular(69)),
                                              child: Container(
                                                color: Colors.white,
                                                padding: new EdgeInsets.all(8),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(65)),
                                                  child: Image.asset(
                                                      'assets/developers/kevin.jpg',    
                                                      height: 110,
                                                      width: 110,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.20,
                                            left: MediaQuery.of(context).size.width*0.14,
                                            child: Center(
                                              child: Container(
                                                padding: new EdgeInsets.fromLTRB(6,16,16,16),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'Kevin Patel',
                                                      style: TextStyle(
                                                        color: Colors.black.withOpacity(0.7),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'Project Manager,',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'BA & Developer',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.solidEnvelope),
                                                          onPressed: () async {
                                                            const url = 'mailto:patelkvin04@gmail.com';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.linkedin),
                                                          onPressed: () async {
                                                            const url = 'https://www.linkedin.com/in/kevinpatel04/';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.github),
                                                          onPressed: () async {
                                                            const url = 'https://github.com/KevinPatel04';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ResponsiveContainer(
                  widthPercent: 72,
                  heightPercent: 43,
                  child: Container(
                    child: Card(
                      elevation: 6,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                              child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          ResponsiveContainer(
                                            heightPercent: 40,
                                            widthPercent: 72,
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperTwo(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.9),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.17,
                                            ),
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperOne(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.3),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.18,
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.07,
                                            left: MediaQuery.of(context).size.width*0.20,
                                            child: ClipRRect(
                                              borderRadius: new BorderRadius.all(Radius.circular(69)),
                                              child: Container(
                                                color: Colors.white,
                                                padding: new EdgeInsets.all(8),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(65)),
                                                  child: Image.asset(
                                                      'assets/developers/siddharth.jpg',    
                                                      height: 110,
                                                      width: 110,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.20,
                                            left: MediaQuery.of(context).size.width*0.14,
                                            child: Center(
                                              child: Container(
                                                padding: new EdgeInsets.fromLTRB(6,16,16,16),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'Siddharth Patel',
                                                      style: TextStyle(
                                                        color: Colors.black.withOpacity(0.7),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'UI Designer',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        '&',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'Developer',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.solidEnvelope),
                                                          onPressed: () async {
                                                            const url = 'mailto:patelkvin04@gmail.com';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.linkedin),
                                                          onPressed: () async {
                                                            const url = 'https://www.linkedin.com/in/kevinpatel04/';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.github),
                                                          onPressed: () async {
                                                            const url = 'https://github.com/KevinPatel04';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ResponsiveContainer(
                  widthPercent: 72,
                  heightPercent: 43,
                  child: Container(
                    child: Card(
                      elevation: 6,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                              child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          ResponsiveContainer(
                                            heightPercent: 40,
                                            widthPercent: 72,
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperTwo(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.9),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.17,
                                            ),
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperOne(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.3),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.18,
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.07,
                                            left: MediaQuery.of(context).size.width*0.20,
                                            child: ClipRRect(
                                              borderRadius: new BorderRadius.all(Radius.circular(69)),
                                              child: Container(
                                                color: Colors.white,
                                                padding: new EdgeInsets.all(8),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(65)),
                                                  child: Image.asset(
                                                      'assets/developers/nisarg.jpg',    
                                                      height: 110,
                                                      width: 110,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.20,
                                            left: MediaQuery.of(context).size.width*0.14,
                                            child: Center(
                                              child: Container(
                                                padding: new EdgeInsets.fromLTRB(6,16,16,16),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'Nisarg Patel',
                                                      style: TextStyle(
                                                        color: Colors.black.withOpacity(0.7),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'Flutter Developer',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.solidEnvelope),
                                                          onPressed: () async {
                                                            const url = 'mailto:patelkvin04@gmail.com';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.linkedin),
                                                          onPressed: () async {
                                                            const url = 'https://www.linkedin.com/in/kevinpatel04/';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.github),
                                                          onPressed: () async {
                                                            const url = 'https://github.com/niss10';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ResponsiveContainer(
                  widthPercent: 72,
                  heightPercent: 43,
                  child: Container(
                    child: Card(
                      elevation: 6,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                              child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          ResponsiveContainer(
                                            heightPercent: 40,
                                            widthPercent: 72,
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperTwo(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.9),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.17,
                                            ),
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperOne(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.3),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.18,
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.07,
                                            left: MediaQuery.of(context).size.width*0.20,
                                            child: ClipRRect(
                                              borderRadius: new BorderRadius.all(Radius.circular(69)),
                                              child: Container(
                                                color: Colors.white,
                                                padding: new EdgeInsets.all(8),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(65)),
                                                  child: Image.asset(
                                                      'assets/developers/meet.jpg',    
                                                      height: 110,
                                                      width: 110,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.20,
                                            left: MediaQuery.of(context).size.width*0.14,
                                            child: Center(
                                              child: Container(
                                                padding: new EdgeInsets.fromLTRB(6,16,16,16),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'Meet Ramaiya',
                                                      style: TextStyle(
                                                        color: Colors.black.withOpacity(0.7),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'Flutter Developer',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.solidEnvelope),
                                                          onPressed: () async {
                                                            const url = 'mailto:patelkvin04@gmail.com';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.linkedin),
                                                          onPressed: () async {
                                                            const url = 'https://www.linkedin.com/in/kevinpatel04/';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.github),
                                                          onPressed: () async {
                                                            const url = 'https://github.com/MeetR18';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ResponsiveContainer(
                  widthPercent: 72,
                  heightPercent: 43,
                  child: Container(
                    child: Card(
                      elevation: 6,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                              child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          ResponsiveContainer(
                                            heightPercent: 40,
                                            widthPercent: 72,
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperTwo(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.9),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.17,
                                            ),
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperOne(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.3),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.18,
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.07,
                                            left: MediaQuery.of(context).size.width*0.20,
                                            child: ClipRRect(
                                              borderRadius: new BorderRadius.all(Radius.circular(69)),
                                              child: Container(
                                                color: Colors.white,
                                                padding: new EdgeInsets.all(8),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(65)),
                                                  child: Image.asset(
                                                      'assets/developers/hussain.jpg',    
                                                      height: 110,
                                                      width: 110,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.20,
                                            left: MediaQuery.of(context).size.width*0.14,
                                            child: Center(
                                              child: Container(
                                                padding: new EdgeInsets.fromLTRB(6,16,16,16),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'Hussain Sadikot',
                                                      style: TextStyle(
                                                        color: Colors.black.withOpacity(0.7),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'Flutter Developer',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.solidEnvelope),
                                                          onPressed: () async {
                                                            const url = 'mailto:patelkvin04@gmail.com';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.linkedin),
                                                          onPressed: () async {
                                                            const url = 'https://www.linkedin.com/in/hussain-sadikot-85175b151/';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.github),
                                                          onPressed: () async {
                                                            const url = 'https://github.com/Ceaser2109';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ResponsiveContainer(
                  widthPercent: 72,
                  heightPercent: 43,
                  child: Container(
                    child: Card(
                      elevation: 6,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                              child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          ResponsiveContainer(
                                            heightPercent: 40,
                                            widthPercent: 72,
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperTwo(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.9),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.17,
                                            ),
                                          ),
                                          ClipPath(
                                            clipper: WaveClipperOne(),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700].withOpacity(0.3),
                                              ),
                                              height: MediaQuery.of(context).size.height*0.18,
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.07,
                                            left: MediaQuery.of(context).size.width*0.20,
                                            child: ClipRRect(
                                              borderRadius: new BorderRadius.all(Radius.circular(69)),
                                              child: Container(
                                                color: Colors.white,
                                                padding: new EdgeInsets.all(8),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(65)),
                                                  child: Image.asset(
                                                      'assets/developers/namrata.jpg',    
                                                      height: 110,
                                                      width: 110,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context).size.height*0.20,
                                            left: MediaQuery.of(context).size.width*0.14,
                                            child: Center(
                                              child: Container(
                                                padding: new EdgeInsets.fromLTRB(6,16,16,16),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'Namrata Patel',
                                                      style: TextStyle(
                                                        color: Colors.black.withOpacity(0.7),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'QA & Tester',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.solidEnvelope),
                                                          onPressed: () async {
                                                            const url = 'mailto:patelkvin04@gmail.com';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.linkedin),
                                                          onPressed: () async {
                                                            const url = 'https://www.linkedin.com/in/kevinpatel04/';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(FontAwesomeIcons.github),
                                                          onPressed: () async {
                                                            const url = 'https://github.com/namrata1310';
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: "Can't Lauch $url",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.BOTTOM,
                                                                  timeInSecForIos: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

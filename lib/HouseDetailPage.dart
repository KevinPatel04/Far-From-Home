import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_carousel/network_image.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';


final String headImageAssetPath="";
final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/farfromhome-2019.appspot.com/o/download.jpg?alt=media&token=eaf87b7c-b495-400c-b7b5-cfea7d455af6',
  'https://firebasestorage.googleapis.com/v0/b/farfromhome-2019.appspot.com/o/images%20(1).jpg?alt=media&token=14c9f7be-84b9-4bef-a8fb-80f4f04b18ec',
  'https://firebasestorage.googleapis.com/v0/b/farfromhome-2019.appspot.com/o/images%20(2).jpg?alt=media&token=4380d318-bb13-4fe9-af8c-4323370387bc',
  'https://firebasestorage.googleapis.com/v0/b/farfromhome-2019.appspot.com/o/images%20(3).jpg?alt=media&token=3d5618cb-d811-49eb-8b41-f32bd547e6f7',
  'https://firebasestorage.googleapis.com/v0/b/farfromhome-2019.appspot.com/o/images%20(4).jpg?alt=media&token=605f222f-57ed-4547-9dd1-9886d41c9936',
  'https://firebasestorage.googleapis.com/v0/b/farfromhome-2019.appspot.com/o/images%20(5).jpg?alt=media&token=181b8dac-782a-49f1-a71c-e04eb9cbae69',
  'https://firebasestorage.googleapis.com/v0/b/farfromhome-2019.appspot.com/o/images%20(6).jpg?alt=media&token=b1ce725a-b671-487c-8576-11421d755dac',
  'https://firebasestorage.googleapis.com/v0/b/farfromhome-2019.appspot.com/o/images.jpg?alt=media&token=aa05f576-bb40-4b0c-9425-23a3c07ba484',
  'https://firebasestorage.googleapis.com/v0/b/farfromhome-2019.appspot.com/o/shangrila.jpg?alt=media&token=35079859-b9c9-4d08-90ed-480906a4f53d'
];

final Widget placeholder = Container(color: Colors.grey);
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  
  int _current = 0;
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  final DocumentReference documentReference =
      Firestore.instance.collection("House").document();
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height*0.30,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: PNetworkImage(
                imgList[index],
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: imgList.length,
          viewportFraction: 1,
          scale: 1,
          pagination: SwiperPagination(),
          ),
      );
  }
}

class HouseDetail extends StatefulWidget {
    // Declare a field that holds the Todo.
  final DocumentSnapshot snapshot;
  HouseDetail(this.snapshot);
  @override
  _HouseDetailState createState() => _HouseDetailState(snapshot);
}

class _HouseDetailState extends State<HouseDetail>{

  final DocumentSnapshot snapshot;
  _HouseDetailState(this.snapshot);
    
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),
            title: Column(children: [
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Shangrila Luxury Apartment",
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        size: 12.0,
                      ),
                      Text(
                        'Vadodara, India',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
            backgroundColor: Colors.blue[700],
            elevation: 0,
          ),
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[700].withOpacity(0.3),
                ),
                height: 410,
              ),
            ),
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[700].withOpacity(0.6),
                ),
                height: 410,
              ),
            ),
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[700].withOpacity(1),
                ),
                height: 400,
              ),
            ),
            Container(
            child: SingleChildScrollView(
              child:Column(children: [
                Stack(
                  
                  children: <Widget>[
                    CarouselWithIndicator(),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Center(
                          child: ClipOval(
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                color: Colors.white,
                                child: new RawMaterialButton(
                                  elevation: 10.0,
                                  child: new Icon(
                                    Icons.favorite,
                                    color:(_isPressed) ? Colors.blue[700] : Colors.grey,
                                  ),
                                onPressed: (){
                                  setState(() {
                                    _isPressed = _isPressed ? false : true;
                                  });
                                  Fluttertoast.showToast(
                                      msg: (_isPressed) ? "Added to Favorites" : "Removed from Favorites",
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  getCards(), 
                 // GetUrl(),
                ], 
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class GetUrl extends StatefulWidget{
  @override
  _GetUrlState createState() => _GetUrlState();
}
class _GetUrlState extends State<GetUrl>
{
  //final DocumentReference documentReference =
  //  Firestore.instance.collection("House").document();
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        body: new StreamBuilder(
          stream: Firestore.instance.collection("House").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              child: Text(
                'No Data...',
              );
            } else { 
              print('++++++++++++++++++++++++++++++++++____________________________--------------------------------');
              Future<DocumentSnapshot> items = snapshot.data.document("zYIB7WWoAClATPMZqLK2")['description'];
              print("..................+++++++++++++++++++++++++$items");
              child: Text(items.toString());
              //return  CarouselWithIndicator();
            }
          }
        )
      );
  }
}


Widget getFirstCard(){
  return Center(
          child: Card(
            elevation: 6,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(0.0),
                    child: Container(
                      padding: new EdgeInsets.fromLTRB(15, 16, 15, 16),
                      child: Row(
                        children: <Widget>[
                          Text('Kevin Patel'),
                          SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.phoneAlt),
                            onPressed: (){},
                          ),
                          // Body Here
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
}

Widget getSecondCard(){
  return 
  Center(
    child: Card(
      elevation: 6,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(0.0),
          child: Container(
            child: Row(
              children: <Widget>[
                ResponsiveContainer(
                  widthPercent: 67,
                  heightPercent: 9,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: new EdgeInsets.fromLTRB(15,16,5,0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '2 BHK in Vadodara',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.6)
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.fromLTRB(15,0,5,16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'At Shangrila Luxury Apartment',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.6)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ResponsiveContainer(
                  widthPercent: 26,
                  heightPercent: 9,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: new EdgeInsets.fromLTRB(10,16,10,0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '1,300',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.6)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Container(
                            padding: new EdgeInsets.fromLTRB(10,0,10,16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Sq. ft.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
}


Widget getThirdCard(){
  return
Center(
                        child: Card(
                          elevation: 6,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(0.0),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    ResponsiveContainer(
                                      widthPercent: 47,
                                      heightPercent: 9,
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: new EdgeInsets.fromLTRB(15,16,5,0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        FontAwesomeIcons.rupeeSign,
                                                        color: Colors.black.withOpacity(0.6),
                                                        ),
                                                      Text(
                                                      '50,000',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black.withOpacity(0.6)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ),
                                            ),
                                            Container(
                                              padding: new EdgeInsets.fromLTRB(15,0,5,16),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Security Deposit',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black.withOpacity(0.6)
                                                    ),
                                                  ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ResponsiveContainer(
                                      widthPercent: 47,
                                      heightPercent: 9,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide( //                   <--- left side
                                              color: Colors.grey,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: new EdgeInsets.fromLTRB(10,16,10,0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons.rupeeSign,
                                                      color: Colors.black.withOpacity(0.6),
                                                    ),
                                                    Text(
                                                      '25,000',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black.withOpacity(0.6)),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: new EdgeInsets.fromLTRB(10,0,10,16),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Rent per month',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black.withOpacity(0.6)
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  ),
                              ),
                            ),
                          ),
                        ),
                      );
}

Widget getFourthCard(){
  return Center(
          child: Card(
            elevation: 6,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(0.0),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      ResponsiveContainer(
                        widthPercent: 47,
                          heightPercent: 9,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: new EdgeInsets.fromLTRB(15,16,5,0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Fully Furnished',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black.withOpacity(0.6)
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: new EdgeInsets.fromLTRB(15,0,5,16),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Furnishing Status',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.5)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ResponsiveContainer(
                          widthPercent: 47,
                          heightPercent: 9,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide( //                   <--- left side
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: new EdgeInsets.fromLTRB(10,16,10,0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Anyone',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black.withOpacity(0.6)),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: new EdgeInsets.fromLTRB(10,0,10,16),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Prefered Tanents',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black.withOpacity(0.5)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
}

Widget getFifthCard(){
  return Center(
          child: Card(
            elevation: 6,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(0.0),
                child: Container(
                  padding: new EdgeInsets.fromLTRB(15, 16, 15, 16),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide( //                   <--- left side
                                color: Colors.blue[500].withOpacity(0.6),
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Text(
                            'OVERVIEW',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ResponsiveContainer(
                                    widthPercent: 44,
                                    heightPercent: 5,
                                    child: Container(
                                      padding: new EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                          left: BorderSide(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                          right: BorderSide(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(FontAwesomeIcons.bed,color: Colors.black.withOpacity(0.6)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '2 Bedroom',
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ResponsiveContainer(
                                      widthPercent: 44,
                                      heightPercent: 3,
                                      child: Container(
                                        padding: new EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                            left: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                            right: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        child: Text('Hello 2'),
                                      ),
                                    ),
                                    ResponsiveContainer(
                                      widthPercent: 44,
                                      heightPercent: 3,
                                      child: Container(
                                        padding: new EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                            left: BorderSide(
                                              color: Colors.grey,
                                              width: 1.5,
                                            ),
                                            right: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        child: Text('Hello 3'),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    ResponsiveContainer(
                                      widthPercent: 43,
                                      heightPercent: 3,
                                      child: Container(
                                        padding: new EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                            right: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        child: Text('Hello 4'),
                                      ),
                                    ),
                                    ResponsiveContainer(
                                      widthPercent: 43,
                                      heightPercent: 3,
                                      child: Container(
                                        padding: new EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Colors.grey,
                                                width: 2,
                                              ),
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          child: Text('Hello 5'),
                                        ),
                                      ),
                                      ResponsiveContainer(
                                        widthPercent: 43,
                                        heightPercent: 3,
                                          child: Container(
                                            padding: new EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Colors.grey,
                                                width: 2,
                                              ),
                                              right: BorderSide(
                                                color: Colors.grey,
                                                width: 2,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          child: Text('Hello 6'),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                ),
              ),
            );
}

Widget getSixthCard(){
    return Center(
            child: Card(
              elevation: 6,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(0.0),
                  child: Container(
                    padding: new EdgeInsets.fromLTRB(15, 16, 15, 16),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide( //                   <--- left side
                                  color: Colors.blue[500].withOpacity(0.6),
                                  width: 3.0,
                                ),
                              ),
                            ),
                            child: Text(
                              'DESCRIPTION',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.7),
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // body here
                      ],
                    )
                  ),
                ),
              ),
            ),
          );
}

Widget getSeventhCard(){
  return Center(
          child: Card(
            elevation: 6,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(0.0),
                child: Container(
                  padding: new EdgeInsets.fromLTRB(15, 16, 15, 16),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide( //                   <--- left side
                                color: Colors.blue[500].withOpacity(0.6),
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Text(
                            'AMENITIES',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.7),
                            )
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Body Here
                    ],
                  )
                ),
              ),
            ),
          ),
        );
}

Widget getEightCard(){
  return  Center(
            child: Card(
              elevation: 6,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(0.0),
                    child: Container(
                      padding: new EdgeInsets.fromLTRB(15, 16, 15, 16),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide( //                   <--- left side
                                    color: Colors.blue[500].withOpacity(0.6),
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'OWNER\'S DETAILS',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(0.7),
                                )
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // Body Here
                        ],
                      )
                    ),
                  ),
                ),
              ),
            );
}

Widget getNinthCard(){
  return Center(
          child: Card(
            elevation: 6,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(0.0),
                child: Container(
                  padding: new EdgeInsets.fromLTRB(15, 16, 15, 16),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide( //                   <--- left side
                                color: Colors.blue[500].withOpacity(0.6),
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Text(
                            'CONTACT OWNER',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Body Here
                    ],
                  )
                ),
              ),
            ),
          ),
        );
}


Widget getCards(){

  return Container(
            padding: new EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: Column(
                children: <Widget>[
// First Card
                getFirstCard(),
// Second Card
                getSecondCard(),
// Third Card Deposit & Rent
                getThirdCard(),
// Fourth Card
                getFourthCard(),
// Fifth Card
                getFifthCard(),
// Sixth Card
                getSixthCard(),
// Seventh Card
                getSeventhCard(),
// Eight Card
                getEightCard(),
// Eight Card
                getNinthCard(),
              ],
            ),
          );

}
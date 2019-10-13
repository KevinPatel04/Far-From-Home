import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfromhome/ui/page_houe_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farfromhome/model/models.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:farfromhome/utils/utils.dart' as prefix0;
import 'package:farfromhome/widgets/widgets.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:intl/intl.dart';

class SearchResultPage extends StatefulWidget {
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  Screen size;
  int _selectedIndex = 0;

  List<Property> premiumList =  List();
  List<Property> featuredList =  List();
  var citiesList = ["Ahmedabad", "Mumbai", "Delhi ", "Chennai","Goa","Kolkata","Indore","Jaipur"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text('Search Results'),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('House').snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == null )
          ? new Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue[700],
            ),
          )
          : Container(
            padding: new EdgeInsets.symmetric(horizontal: 10,vertical: 16),
            child: ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot docsSnap = snapshot.data.documents[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    getCard(docsSnap, context,index),
                  ],
                );
              },
            ),
          );
        }
      ),
    );
  }


  Widget upperPart() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: size.getWidthPx(240),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorCurve, colorCurveSecondary],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: size.getWidthPx(36)),
              child: Column(
                children: <Widget>[
                  titleWidget(),
                  SizedBox(height: size.getWidthPx(1)),
                  upperBoxCard(),
                ],
              ),
            ),
            //searchResult(),
            
          ],
        ),
      ],
    );
  }

  List<bool> _isPressed = List<bool>();

   Widget getCard(DocumentSnapshot docsSnap,var context,index){
     _isPressed.add(false);
        return Column(
              children: <Widget>[
                      Stack(
                            children: <Widget>[
                              ResponsiveContainer(
                                widthPercent: 90,
                                heightPercent: 35,
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      // Navigate
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HouseDetail(docsSnap),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width*0.90,
                                            height: MediaQuery.of(context).size.height*0.25,
                                            color: Colors.grey,
                                            child: Image.network(
                                              '${docsSnap['houseImages'][0]}',
                                              fit: BoxFit.fill
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            ResponsiveContainer(
                                              widthPercent: 23,
                                              heightPercent: 9,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      right: BorderSide( 
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text('${docsSnap['builtUpArea']} Sq.ft.')
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ResponsiveContainer(
                                              widthPercent: 41,
                                              heightPercent: 9,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                      right: BorderSide( 
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Align(
                                                        child: Text('${docsSnap['Overview']['room']} BHK in ${docsSnap['Address']['city']}')
                                                      ),
                                                      Align(
                                                        child: Text('${docsSnap['Overview']['furnishingStatus']}')
                                                      ),
                                                    ],
                                                  ),
                                              ),
                                            ),
                                            ResponsiveContainer(
                                              widthPercent: 23,
                                              heightPercent: 9,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                                child: Container(
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Text('${docsSnap['monthlyRent']}'),
                                                      ),
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Text('Rs. / month'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ) 
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                            right: 20,
                            top: 20,
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
                                          color:_isPressed[index] ? Colors.blue[700] : Colors.grey,
                                    ),
                                  onPressed: (){
                                      setState(() {
                                        _isPressed[index] = !_isPressed[index];
                                      });
                                      
                                    Fluttertoast.showToast(
                                        msg: (_isPressed[index]) ? "${docsSnap['Address']['society']} Added to Favorites" : "Removed from Favorites",
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
      SizedBox(
        height: 10.0,
      ),
    ]);
  }

  Widget titleWidget() {
    return Row(
      children: <Widget>[
        IconButton(
          padding: new EdgeInsets.fromLTRB(1,1,0,0),
          icon: Icon(
            FontAwesomeIcons.bars,
            color: Colors.white,
          ),
          onPressed: (){
            
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Text("Which type of house",
                  style: TextStyle(
                      fontFamily: 'Exo2',
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white
                    ),
                  ),
              Text("would you like to buy?",
                style: TextStyle(
                    fontFamily: 'Exo2',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Card upperBoxCard() {
    return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(
            horizontal: size.getWidthPx(20), vertical: size.getWidthPx(0)),
        borderOnForeground: true,
        child: Container(
          height: size.getWidthPx(150),
          child: Column(
            children: <Widget>[
              _searchWidget(),
              leftAlignText(
                  text: "Top Cities :",
                  leftPadding: size.getWidthPx(16),
                  textColor: textPrimaryColor,
                  fontSize: 16.0),
              HorizontalList(
                children: <Widget>[
                  for(int i=0;i<citiesList.length;i++)
                    buildChoiceChip(i, citiesList[i])
                ],
              ),
            ],
          ),
        ));
  }

  BoxField _searchWidget() {
    return BoxField(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        hintText: "Select by city, area or locality.",
        lableText: "Search...",
        obscureText: false,
        onSaved: (String val) {
          
        },
        icon: Icons.search,
        iconColor: colorCurve);
  }

  Padding leftAlignText({text, leftPadding, textColor, fontSize, fontWeight}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text??"",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: fontSize,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor)),
      ),
    );
  }

  Card propertyCard(Property property) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        borderOnForeground: true,
        child: Container(
            height: size.getWidthPx(150),
            width: size.getWidthPx(170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0)),
                    child: Image.asset('assets/${property.image}',
                        fit: BoxFit.fill)),
                SizedBox(height: size.getWidthPx(8)),
                leftAlignText(
                    text: property.propertyName,
                    leftPadding: size.getWidthPx(8),
                    textColor: colorCurve,
                    fontSize: 14.0),
                leftAlignText(
                    text: property.propertyLocation,
                    leftPadding: size.getWidthPx(8),
                    textColor: Colors.black54,
                    fontSize: 12.0),
                SizedBox(height: size.getWidthPx(4)),
                leftAlignText(
                  text: NumberFormat.compactCurrency(
                        decimalDigits: 2,
                        symbol: '\u20b9'
                    ).format(double.parse(property.propertyPrice)),
                    leftPadding: size.getWidthPx(8),
                    textColor: colorCurve,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800),
              ],
            ),
          ),
        );
  }

  Padding buildChoiceChip(index, chipName) {
    return Padding(
      padding: EdgeInsets.only(left: size.getWidthPx(8)),
      child: ChoiceChip(
        backgroundColor: backgroundColor,
        selectedColor: colorCurve,
        labelStyle: TextStyle(
            fontFamily: 'Exo2',
            color:
                (_selectedIndex == index) ? backgroundColor : textPrimaryColor),
        elevation: 4.0,
        padding: EdgeInsets.symmetric(
            vertical: size.getWidthPx(4), horizontal: size.getWidthPx(12)),
        selected: (_selectedIndex == index) ? true : false,
        label: Text(chipName),
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}


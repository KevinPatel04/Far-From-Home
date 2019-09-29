import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    premiumList
    ..add(Property(propertyName:"Omkar Lotus", propertyLocation:"Ahmedabad ", image:"feature_1.jpg", propertyPrice:"26000"))
    ..add(Property(propertyName:"Sandesh Heights", propertyLocation:"Baroda ", image:"feature_2.jpg", propertyPrice:"11500"))
    ..add(Property(propertyName:"Sangath Heights", propertyLocation:"Pune ", image:"feature_3.jpg", propertyPrice:"19000"))
    ..add(Property(propertyName:"Adani HighRise", propertyLocation:"Mumbai ", image:"hall_1.jpg", propertyPrice:"225000"))
    ..add(Property(propertyName:"N.G Tower", propertyLocation:"Gandhinagar ", image:"hall_2.jpeg", propertyPrice:"75000"))
    ..add(Property(propertyName:"Vishwas CityRise", propertyLocation:"Pune ", image:"hall_1.jpg", propertyPrice:"17500"))
    ..add(Property(propertyName:"Gift City", propertyLocation:"Ahmedabad ", image:"hall_2.jpeg", propertyPrice:"13500000"))
    ..add(Property(propertyName:"Velone City", propertyLocation:"Mumbai ", image:"feature_1.jpg", propertyPrice:"11500000"))
    ..add(Property(propertyName:"PabelBay", propertyLocation:"Ahmedabad ", image:"hall_1.jpg", propertyPrice:"33000000"))
    ..add(Property(propertyName:"Sapath Hexa Tower", propertyLocation:"Ahmedabad", image:"feature_3.jpg", propertyPrice:"156000"));
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: backgroundColor),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                upperPart()
              ],
            ),
          ),
        ),
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
            searchResult(),
          ],
        ),
      ],
    );
  }

  Widget searchResult(){
    return Center(
      child: Text('House List will Comet here'),
    );
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

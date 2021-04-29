import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfromhome/ui/page_house_detail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:farfromhome/model/models.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:farfromhome/widgets/widgets.dart';
import 'package:responsive_container/responsive_container.dart';
var userRef;
class SearchResultPage extends StatefulWidget {
  SearchResultPage(u){
    userRef=u;
  }
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  Screen size;
  int _selectedIndex = 0;
  String user;
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('House').snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == null )
          ? new Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue[700],
            ),
          )
          : Container(
            child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot docsSnap = snapshot.data.documents[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        index == 0 ? upperPart() : SizedBox(width: 0,),
                        index == 0 ? SizedBox(height: 10,):SizedBox(height: 0),
                        Container(
                          padding: new EdgeInsets.symmetric(horizontal: 10),
                          child: getCard(docsSnap,context,index,userRef)
                        ),
                      ],
                    );
                  },
              )
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
            height: size.getWidthPx(140),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorCurve, colorCurve],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: size.getWidthPx(6)),
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
    
   Widget getCard(DocumentSnapshot docsSnap,var context,index,var userReference){
        //setStatus(snapshot);
        _isPressed.add(false);
        return Column(
              children: <Widget>[
                      Stack(
                            children: <Widget>[
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                margin: new EdgeInsets.all(8),
                                borderOnForeground: true,
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
                                          width: MediaQuery.of(context).size.width*0.92,
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
                                              color: _isPressed[index] ? Colors.blue[700] : Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isPressed[index] = !_isPressed[index];
                                              });
                                              if(_isPressed[index]){
                                                FirebaseFirestore.instance.runTransaction((transaction) async{
                                                docsSnap = await transaction.get(docsSnap.reference);
                                                await transaction.update(docsSnap.reference,{
                                                  'favourite': docsSnap['favourite']+1,
                                                });
                                                });
                                                FirebaseFirestore.instance.doc(userReference).update({
                                                  'FavouriteHouse':FieldValue.arrayUnion(['/House/'+docsSnap.id])
                                                });
                                              } else{
                                                FirebaseFirestore.instance.runTransaction((transaction) async{
                                                  docsSnap = await transaction.get(docsSnap.reference);
                                                  await transaction.update(docsSnap.reference,{
                                                    'favourite': docsSnap['favourite']-1,
                                                  });
                                                });
                                                FirebaseFirestore.instance.doc(userReference).update({
                                                  'FavouriteHouse':FieldValue.arrayRemove(['/House/'+docsSnap.id])
                                                });
                                              }
                                              Fluttertoast.showToast(
                                                  msg: (_isPressed[index])
                                                      ? "${docsSnap['Address']['society']} Added to Favorites"
                                                      : "Removed from Favorites",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
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
          padding: new EdgeInsets.fromLTRB(1,0,0,0),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.pop(context);
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
          height: size.getWidthPx(60),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Center(
                  child: Hero(
                    tag: 'searcHero',
                    child: _searchWidget(),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // leftAlignText(
              //     text: "Top Cities :",
              //     leftPadding: size.getWidthPx(16),
              //     textColor: textPrimaryColor,
              //     fontSize: 16.0),
              // HorizontalList(
              //   children: <Widget>[
              //     for(int i=0;i<citiesList.length;i++)
              //       buildChoiceChip(i, citiesList[i])
              //   ],
              // ),
            ],
          ),
        ));
  }

Widget _searchWidget() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    size = Screen(MediaQuery.of(context).size);
    return Container(
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: height / 400),
                  padding: EdgeInsets.all(size.getWidthPx(0)),
                  alignment: Alignment.center,
                  height: size.getWidthPx(40),
                  decoration:  BoxDecoration(
                      color: Colors.grey.shade100,
                      border:  Border.all(color: Colors.grey.shade400, width: 1.0),
                      borderRadius:  BorderRadius.circular(8.0)),
                  child: Row(children: <Widget>[
                    SizedBox(width: size.getWidthPx(10),),
                    Icon(Icons.search,color: colorCurve),
                    Text("Customize you search...")
                  ],) 
              ),),
          ],
        ),
        padding: EdgeInsets.only(bottom :size.getWidthPx(8)),
        margin: EdgeInsets.only(top: size.getWidthPx(8), right: size.getWidthPx(8), left:size.getWidthPx(8)),
    );
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


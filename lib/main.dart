import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_carousel/HouseDetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: ListPage(),
  ));
}

class ListPage extends StatefulWidget{
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  int ref = 20;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: new AppBar(
          title: Text("Far From Home"),
          backgroundColor: Colors.blue[700],
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
                DocumentSnapshot docsSnap =
                snapshot.data.documents[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    getCard(docsSnap, context),
                  ],
                );
              },
            ),
          );
        }
      )
    );
  }

  Widget getCard(DocumentSnapshot docsSnap,var context){
    return Column(
          children: <Widget>[
                  Stack(
                        children: <Widget>[
                          ResponsiveContainer(
                            widthPercent: 90,
                            heightPercent: 35,
                            child: Card(
                              elevation: 10,
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
                                      color:(_isPressed) ? Colors.blue[700] : Colors.grey,
                                    ),
                                  onPressed: (){
                                      setState(() {
                                        _isPressed = _isPressed ? false : true;
                                      });
                                      
                                    Fluttertoast.showToast(
                                        msg: (_isPressed) ? "${docsSnap['Address']['city']} Added to Favorites" : "Removed from Favorites",
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

}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfromhome/ui/page_payment.dart';
import 'package:flutter/material.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  var docPath,_source;
  ProfilePage(this.docPath,this._source);
  @override
  _ProfilePageState createState() => _ProfilePageState(docPath,_source);
}

class _ProfilePageState extends State<ProfilePage> {
  Screen size;
  var docSnap,docPath,_source;
  _ProfilePageState(this.docPath,this._source);

  @override
  void initState(){
    super.initState();
    //addSnapshot();
  }

  void addSnapshot(){
    FirebaseFirestore.instance.doc(docPath).get().then((doc){
      print('doc found');
      print(doc['firstName']);
      setState((){
        docSnap=doc;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: colorCurve,
        title: Text('User Profile'),
        elevation: 0,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.doc(docPath).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: const CircularProgressIndicator());
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  docSnap = snapshot.data;
                  return Column(children: <Widget>[
                    Container(
                      height: 700.0,
                      child: Stack(children: <Widget>[
                        FractionallySizedBox(
                          widthFactor: 1,
                          heightFactor: 0.4,
                          child: Container(
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: docSnap['profileImage']!=null ? NetworkImage(docSnap['profileImage']) : AssetImage('assets/icons/avatar.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(size.getWidthPx(16),size.getWidthPx(200), size.getWidthPx(16), size.getWidthPx(16)),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(size.getWidthPx(16)),
                                    margin: EdgeInsets.only(top: size.getWidthPx(16)),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(size.getWidthPx(5))
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: size.getWidthPx(96)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(docSnap['firstName']+' '+docSnap['lastName'],style: new TextStyle( fontSize: size.getWidthPx(25))),
                                              docSnap['city']!=null ? Row(children: <Widget>[
                                                Icon(Icons.location_on),
                                                Text(docSnap['city'],style: new TextStyle(fontSize: size.getWidthPx(20)))
                                              ],): SizedBox(width: 0,),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: size.getWidthPx(20),),
                                        Align(
                                          alignment: Alignment.center,
                                          child: _source ? Padding(
                                                padding: new EdgeInsets.symmetric(horizontal: size.getWidthPx(70)),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: size.getWidthPx(40),
                                                      height: size.getWidthPx(40),
                                                      decoration: BoxDecoration(
                                                          borderRadius: new BorderRadius.circular(size.getWidthPx(20)),
                                                          border: new Border.all(
                                                            width: size.getWidthPx(1),
                                                            color: Colors.transparent
                                                          ),
                                                          color: Colors.greenAccent.shade700,
                                                      ),
                                                      child: Center(
                                                        child: IconButton(
                                                          tooltip: "Call",
                                                          icon: Icon(
                                                            FontAwesomeIcons.phoneAlt,
                                                            size: size.getWidthPx(17),
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () async {
                                                            var url = "tel:"+docSnap['mobileNo'].toString();
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                msg: "Can't Lauch Phone",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.BOTTOM,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.black,
                                                                textColor: Colors.white,
                                                                fontSize: size.getWidthPx(15)
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: size.getWidthPx(12)),
                                                    Container(
                                                      width: size.getWidthPx(40),
                                                      height: size.getWidthPx(40),
                                                      decoration: BoxDecoration(
                                                          borderRadius: new BorderRadius.circular(size.getWidthPx(20)),
                                                          border: new Border.all(
                                                            width: size.getWidthPx(1),
                                                            color: Colors.transparent
                                                          ),
                                                          color: Colors.redAccent,
                                                      ),
                                                      child: Center(
                                                        child: IconButton(
                                                          tooltip: "Chat",
                                                          icon: Icon(
                                                            FontAwesomeIcons.solidComment,
                                                            size: size.getWidthPx(17),
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () async {
                                                          //   Fluttertoast.showToast(
                                                          //     msg: "Start Chatting with ${docsSnap['firstName']}",
                                                          //     toastLength: Toast.LENGTH_SHORT,
                                                          //     gravity: ToastGravity.BOTTOM,
                                                          //     timeInSecForIos: 1,
                                                          //     backgroundColor: Colors.black,
                                                          //     textColor: Colors.white,
                                                          //     fontSize: size.getWidthPx(15)
                                                          //   );
                                                          var url = "sms:"+docSnap['mobileNo'].toString();
                                                            if (await canLaunch(url)) {
                                                              await launch(url);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                msg: "Can't Lauch Phone",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.BOTTOM,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.black,
                                                                textColor: Colors.white,
                                                                fontSize: size.getWidthPx(15)
                                                              );
                                                            }
                                                          }
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: size.getWidthPx(10)),
                                                    Container(
                                                      width: size.getWidthPx(40),
                                                      height: size.getWidthPx(40),
                                                      decoration: BoxDecoration(
                                                          borderRadius: new BorderRadius.circular(size.getWidthPx(20)),
                                                          border: new Border.all(
                                                            width: size.getWidthPx(1),
                                                            color: Colors.transparent
                                                          ),
                                                          color: Colors.blueAccent,
                                                      ),
                                                      child: Center(
                                                        child: IconButton(
                                                          tooltip: "Pay Rent",
                                                          icon: Icon(
                                                            FontAwesomeIcons.wallet,
                                                            size: size.getWidthPx(17),
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () async {
                                                            Navigator.push(context, 
                                                                MaterialPageRoute(builder: (_)=> PaymentPage(docSnap)));
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ) : SizedBox(height: 0,),
                                        ),
                                        SizedBox(height: 10.0),
                                        Divider(),
                                        Row(children: <Widget>[
                                          Icon(Icons.person,color: Colors.grey,),
                                          SizedBox(width: size.getWidthPx(10)),
                                          Text("Name",style: new TextStyle(fontSize: size.getWidthPx(16),color: Colors.grey),),
                                          SizedBox(height: size.getWidthPx(10)),
                                        ],),
                                        SizedBox(height: size.getWidthPx(10)),
                                        Text(docSnap['firstName']+' '+docSnap['lastName'],style: new TextStyle(fontSize: size.getWidthPx(16))),
                                        Divider(thickness: size.getWidthPx(1),color: Colors.grey,),
                                        SizedBox(height: size.getWidthPx(10),),
                                        Row(children: <Widget>[
                                          Icon(Icons.phone,color: Colors.grey,),
                                          SizedBox(width: size.getWidthPx(10),),
                                          Text("Phone Number",style: new TextStyle(color: Colors.grey,fontSize: size.getWidthPx(16))),
                                        ],),
                                        SizedBox(height: size.getWidthPx(10),),
                                        Text(docSnap['mobileNo'],style: new TextStyle(fontSize: size.getWidthPx(16))),
                                        Divider(thickness: size.getWidthPx(1),color: Colors.grey,),
                                        SizedBox(height: size.getWidthPx(10),),
                                        Row(children: <Widget>[
                                          Icon(Icons.email,color: Colors.grey,),
                                          SizedBox(width: size.getWidthPx(10),),
                                          Text("E-Mail",style: new TextStyle(color: Colors.grey,fontSize: size.getWidthPx(16))),
                                        ],),
                                        SizedBox(height: size.getWidthPx(10),),
                                        Text(docSnap['email'],style: new TextStyle(fontSize: size.getWidthPx(16))),
                                        Divider(thickness: size.getWidthPx(1),color: Colors.grey,),
                                        SizedBox(height: size.getWidthPx(10),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                            image: docSnap['profileImage']!=null ? NetworkImage(docSnap['profileImage']) : AssetImage('assets/icons/avatar.png'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    margin: EdgeInsets.only(left: 16.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                      ),
                    ),
                  ]);
                });
          }),
    );
  }
}
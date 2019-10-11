import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:farfromhome/utils/utils.dart';


class ProfilePage extends StatefulWidget {
  var docPath;
  ProfilePage(this.docPath);
  @override
  _ProfilePageState createState() => _ProfilePageState(docPath);
}

class _ProfilePageState extends State<ProfilePage> {
  Screen size;
  var docSnap,docPath;
  _ProfilePageState(this.docPath);

  @override
  void initState(){
    super.initState();
    //addSnapshot();
  }

  void addSnapshot(){
    Firestore.instance.document(docPath).get().then((doc){
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
        elevation: 0,
      ),
      body: StreamBuilder(
          stream: Firestore.instance.document(docPath).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: const CircularProgressIndicator());
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  docSnap = snapshot.data;
                  return Column(children: <Widget>[
                    Text(
                      docSnap['firstName']
                    ),
                    
                  ]);
                });
          }),
    );
  }
}
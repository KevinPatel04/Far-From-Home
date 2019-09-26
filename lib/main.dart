import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_carousel/HouseDetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: ListPage(),
  ));
}

class ListPage extends StatelessWidget {
  int ref = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
        backgroundColor: Colors.blue[700],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("House").snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData) return Text('Loading'); 
          new ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index){
              return new ListTile(
                title: new Text(snapshot.data.documents[index]['monthlyRent']),
                subtitle: new Text(snapshot.data.documents[index]['description']),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HouseDetail(snapshot.data.douments[index]),
                    ),
                  );
                }
              );
            });
          })
    );
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PhotosList extends StatefulWidget {
  var docRef;
  PhotosList(this.docRef);
  @override
  _PhotosListState createState() => _PhotosListState(docRef);
}

class _PhotosListState extends State<PhotosList> {
  bool isLoading = true;
  bool internetCheck = true;
  List<String> photoList= new List();
  Screen size;
  var docsSnap,docRef;
  _PhotosListState(this.docRef);
  @override
  void initState() {
    super.initState();
    getSnap();
  }
  
  void getSnap() async{
    var document = await FirebaseFirestore.instance.doc('/House/'+docRef);
      document.get().then((DocumentSnapshot doc) {
          setState(() {
            docsSnap = doc;
            addImages();
          });
      });
  }

  void addImages(){
    setState((){photoList=List.from(docsSnap['ReviewImage']);});
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return staggeredBody();
  }

  Padding staggeredBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:size.getWidthPx(8)),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: photoList.length,
        padding: EdgeInsets.only(top: size.getWidthPx(8)),
        itemBuilder: (BuildContext context, int index){
          return Container(
          child: GestureDetector(
              child: Hero(
                tag: 'Image View $index',
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.getWidthPx(8)),
                      border: Border.all(color: hintTextColor),
                      image: DecorationImage(
                          image: NetworkImage(photoList[index]),
                          fit: BoxFit.cover)
                      ),
                    ),
                  ),
              onTap: (){
                _showImage(context,index);
              },
          ),
        );
      },

        staggeredTileBuilder: (int index) => StaggeredTile.count(1, index.isEven ? 1.5 : 1),
        mainAxisSpacing: size.getWidthPx(4),
        crossAxisSpacing: size.getWidthPx(4),
      ),
    );
  }
  void _showImage(BuildContext context,int index){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: colorCurve,
            title: Text(docsSnap['Address']['society']),
            elevation: 0,
          ),
          body: Center(
            child: Hero(
              tag: 'Image View $index',
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(photoList[index]),
                    fit: BoxFit.fitWidth
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
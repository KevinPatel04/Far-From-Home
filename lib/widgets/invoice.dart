import 'dart:async';
import 'dart:io';
import 'package:farfromhome/ui/page_home.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:printing/printing.dart';
import 'document.dart';
import 'invoice_viewer.dart';

class Invoice extends StatefulWidget {
  @override
  InvoiceState createState() {
    return InvoiceState(payment,owner);
  }

  var payment,owner;
  Invoice(this.payment,this.owner);
}

class InvoiceState extends State<Invoice> {
  final GlobalKey<State<StatefulWidget>> shareWidget = GlobalKey();
  final GlobalKey<State<StatefulWidget>> pickWidget = GlobalKey();
  final GlobalKey<State<StatefulWidget>> previewContainer = GlobalKey();
  File file;

  String _filename = "invoice_pay_DQ7WtrNcx5WK58";
  
  var payment,owner;
  InvoiceState(this.payment,this.owner);

  Future<void> _printPdf() async {
    final bool result = await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async =>
            (await generateDocument(format,payment,owner)).save());
    result ? Fluttertoast.showToast(msg: 'Invoice Downloaded Successfully'): null;
    //result ? Navigator.push(context,MaterialPageRoute(builder: (_) => SearchPage())): null;
  }

  Future<void> _saveAsFile() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final File file = File(appDocPath + '/' + '$_filename.pdf');

    // TODO Reset the function to writeAsBytes
    //await file.writeAsBytes(await generateDocument(PdfPageFormat.a4,payment,owner).save());
    final pdf.Document document = await generateDocument(PdfPageFormat.a4,payment,owner);
    file.writeAsString(document.toString());

    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PdfViewer(file: file)),
    );
    Fluttertoast.showToast(msg: 'Invoice Downloaded Successfully');
    //Navigator.push(context,MaterialPageRoute(builder: (_) => SearchPage()));
  }

  Future<void> _sharePdf() async {
    print('Share ...');
    final pdf.Document document = await generateDocument(PdfPageFormat.a4,payment,owner);

    // Calculate the widget center for iPad sharing popup position
    final RenderBox referenceBox =
        shareWidget.currentContext.findRenderObject();
    final Offset topLeft =
        referenceBox.localToGlobal(referenceBox.paintBounds.topLeft);
    final Offset bottomRight =
        referenceBox.localToGlobal(referenceBox.paintBounds.bottomRight);
    final Rect bounds = Rect.fromPoints(topLeft, bottomRight);
    // TODO Fix Future bytes error (uncomment to see error)
    /*await Printing.sharePdf(
        bytes: document.save(), filename: '$_filename.pdf', bounds: bounds);*/
    //Navigator.push(context,MaterialPageRoute(builder: (_) => SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return RepaintBoundary(
        key: previewContainer,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Your Invoice'),
            backgroundColor: colorCurve,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => SearchPage()));
              },
            ),
          ),
          body: Container(
            color: Colors.white,
            padding: new EdgeInsets.all(40),
            child: Center(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: size.hp(12),
                  ),
                  Container(
                    width: size.wp(70),
                    height: size.wp(70),
                    child: Image.asset(
                      'assets/icons/success.png',  
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Payment Successfull',
                      style: TextStyle(
                        fontFamily: 'Ex02',
                        fontSize: 24,
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.hp(2),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Your invoice for the same is generated',
                      style: TextStyle(
                        fontFamily: 'Ex02',
                        fontSize: 16,
                        color: Colors.black45.withOpacity(0.7),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.hp(3),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 67),
                        child: RaisedButton(
                            color: Colors.green[800],
                            textColor: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.file_download,color: Colors.white,),
                                SizedBox(width: 10,),
                                Text('Print Document'),
                              ],
                            ), onPressed: _printPdf),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 67),
                        child: RaisedButton(
                            color: Colors.green[800],
                            key: shareWidget,
                            textColor: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.share,color: Colors.white,),
                                SizedBox(width: 10,),
                                Text('Share Document'),
                              ],
                            ),
                            onPressed: _sharePdf),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.hp(18),
                  ),
                ],
              ), 
            ),
          ),
        ));
  }
}
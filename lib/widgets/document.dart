import 'dart:async';
import 'package:flutter/widgets.dart' as fw;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'example_widgets.dart';

Widget drawLine(size){
  return Container(
      color: grey300,
      height: size * PdfPageFormat.cm,
    );
}

Widget detailWidget(_type,_name,_add1,_city,_mobile,_email){
  var size = PdfPageFormat.cm;
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
        padding: new EdgeInsets.only(top: 1*size),
        // child: Align(
        //   alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _type ? 'Owner\'s Details:' : 'Tenant\'s Details:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: grey800,
                ),
              ),
              Text(
                _name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: grey600,
                ),
              ),
              Text(
                _add1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                  color: grey600,
                ),
              ),
              Text(
                _city,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                  color: grey600,
                ),
              ),
              Text(
                _mobile,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                  color: grey600,
                ),
              ),
              Text(
                _email,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                  color: grey600,
                ),
              ),
            ],
          ),
        ),
      //),
  );
}

Future<Document> generateDocument(PdfPageFormat format,payment,owner) async {
  final Document pdf = Document(title: 'Payment Invoice', author: 'Far From Home');
  var _date = new DateFormat('dd-MM-yyyy').format(payment['dateCreated']);
   
  var size = PdfPageFormat.cm;
  /*final PdfImage profileImage = await PdfImage.file(
      pdf: pdf.document,
      image: fw.NetworkImage(
        'https://firebasestorage.googleapis.com/v0/b/farfromhome-2019.appspot.com/o/logo_inverted.png?alt=media&token=16da4a5e-3db6-4ff2-ae69-c5b134c6b1e8',
      ),
      onError: (dynamic exception, StackTrace stackTrace) {
        print('Far From Home Logo');
      }); */

  pdf.addPage(MyPage(
    pageFormat: format.applyMargin(
        left: 2.0 * size,
        top: 2.0 * size,
        right: 2.0 * size,
        bottom: 2.0 * size),
    build: (Context context) => Center(
      child: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'Far From Home',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: blue,
                      ),
                    ),
                ),
              ),
              
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ClipRRect(
                    child: Container(
                      width: 60,
                      height: 60,
                      color: lightblue,
                      child: Container()))
                      //child: profileImage == null
                      //  ? Container()
                      //  : Image(profileImage))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 0.5 * size,
          ),
          Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'INVOICE # : ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: grey800,
                  ),
                ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                payment['paymentID'],//'pay_DQ7WtrNcx5WK58',
                style: TextStyle(
                  fontSize: 15,
                  color: grey800,
                ),
              ),
            ),
          ]
        ),
        Row(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'ISSUE DATE: ',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: grey800,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                _date,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: grey800,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Tenant's Detail
            Expanded(
              //width: 0.5 * 17 * size,
              child: detailWidget(false,payment['tenantName'],payment['propertyAddress'],payment['city'],payment['tenantContact'],payment['tenantEmail']),
            ),
            
            // Owner's Detail
            Expanded(
              // width: 0.5 * 17 * size,
              child: detailWidget(true,owner['name'],owner['address'],owner['city'],owner['mobileNo'],owner['email']),
            ),
          ],
        ),
        Padding(
          padding: new EdgeInsets.only(top: 1* size),
          child: Expanded(
            child: Container(
              height: 1.5 * size,
              width: 51 * size,
              color: grey300,
              padding: EdgeInsets.all(0.5*size),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Payment ID',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: grey600,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Rent Period',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: grey600,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Payment Status',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: grey600,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Total',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: grey600,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        Padding(
          padding: new EdgeInsets.only(top: 1* size),
          child: Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.5*size),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                        'pay_DQ7WtrNcx5WK58',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: grey600,
                        ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${payment['startDate']}\nto\n${payment['lastDate']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: grey600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'SUCCESS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: grey600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      payment['amount'].toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: grey600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        SizedBox(
          height: 1 * size,
        ),
        drawLine(0.05),
        Expanded(
          child: SizedBox(
              height: 1 * size,
            ),
        ),
        drawLine(0.08),
        SizedBox(
          height: 0.5 * size,
        ),
        Align(
          child: Text(
            'This is a computer generated invoice in return of your payment of rent',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: grey600,
            ),
          ),
        ),
        Align(
          child: Text(
            'Far From Home',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: grey800,
            ),
          ),
        ),
      ],
    ),
  )));
  return pdf;
}
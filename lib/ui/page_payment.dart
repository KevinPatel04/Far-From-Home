import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfromhome/utils/responsive_screen.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentPage extends StatefulWidget {
  DocumentSnapshot docsSnap;
  @override
  _PaymentPageState createState() => _PaymentPageState(docsSnap);
  PaymentPage(this.docsSnap);
}

class _PaymentPageState extends State<PaymentPage> {
  DocumentSnapshot docsSnap;
  _PaymentPageState(this.docsSnap);
  static const platform = const MethodChannel("razorpay_flutter");
  String _mobileNo;
  String _name;
  String _email;
  String _propertyName;
  double _amount;
  Screen size;
  Razorpay _razorpay;
  var _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay Rent to ${docsSnap['firstName']}",
          style: TextStyle(fontFamily: 'Ex02'),
        ),
        backgroundColor: colorCurve,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(size.getWidthPx(20)),
          child: ListView(
            children: <Widget>[
              
              SizedBox(
                height: size.getWidthPx(10),
              ),
               TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name *', 
                  hintText: 'Enter Your Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person)
                ),
                validator: validateName,
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              
              SizedBox(
                height: size.getWidthPx(10),
              ),
               TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Your Email', 
                  labelText: 'Email *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail)
                ),
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(
                height: size.getWidthPx(10),
              ),
               TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number *', 
                  hintText: 'Enter Your Mobile Number',
                  border: OutlineInputBorder(),
                  prefixText: "+91",
                  helperText: 'Verification OTP would be sent on this number',
                  prefixIcon: Icon(Icons.phone)
                ),
                maxLength: 10,
                keyboardType: TextInputType.phone,
                validator: validatePhone,
                onChanged: (value) {
                  setState(() {
                    _mobileNo = value;
                  });
                },
              ),
              SizedBox(
                height: size.getWidthPx(5),
              ),
               TextFormField(
                decoration: InputDecoration(
                  labelText: 'Rent Amount *', 
                  hintText: 'Enter Your Amount',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                ),
                keyboardType: TextInputType.phone,
                validator: validateAmount,
                onChanged: (value) {
                  setState(() {
                    _amount = double.parse(value.toString());
                  });
                },
              ),
              SizedBox(
                height: size.getWidthPx(10),
              ),
               TextFormField(
                 maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Address', 
                  hintText: 'Enter Rented Property Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home)
                ),
                onChanged: (value) {
                  setState(() {
                    _propertyName = value;
                  });
                },
              ),
              SizedBox(
                height: size.getWidthPx(10),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(size.getWidthPx(5)),
                child: Container(
                  width: double.infinity,
                  color: Colors.blue[700],
                  child: FlatButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        openCheckout();
                      }
                    },
                    child: Center(child: Text(
                      "PROCEED FOR PAYMENT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.getWidthPx(20),
                        fontFamily: 'Ex02'
                      ),
                    )),
                  ),
                  height: size.hp(8),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  String validateName(String value) {
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  String validatePhone(String value) {
    if(value.isEmpty) return 'Mobile number is required.';
    final RegExp amtExp = new RegExp(r'^[0-9]+$');
    if(!amtExp.hasMatch(value)) return 'Please enter valid mobile number';
    else if(value.length!=10){
      return 'Mobile number must be 10 digits long';
    }
    return null;
  }

  String validateAmount(String value) {
    if(value.isEmpty) return 'Please provide the amount to be paid.';
    final RegExp amtExp = new RegExp(r'^[0-9]+$');
    if(double.parse(value)<=0.0 || !amtExp.hasMatch(value)){
      return 'Please enter valid amount.';
    }
    return null;
  }

  String validateEmail(String value) {
      if (value.isEmpty) {
        return 'Email is required.';
      }
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value))
        return 'Enter Valid Email';
      else
        return null;
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    //openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_EJrT317PcI5glY',
      'amount': _amount * 100.0,
      'name': _name,
      'description': _propertyName.length>31 ? 'House rent for '+_propertyName.substring(1,30) : 'House rent for '+_propertyName,
      'prefill': {'contact': _mobileNo, 'email': _email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
    Firestore.instance.collection('Payment').add({
      'dateCreated' : new DateTime.now(),
      'amount' : _amount,
      'status' : "SUCCESS",
      'ownerRef' : docsSnap.reference,
      'paymentID' : response.paymentId,
      'propertyAddress' : _propertyName,
      'tenantContact' : "+91$_mobileNo",
      'tenantEmail' : _email,
      'tenantName' : _name,
    });
    
    Timer(Duration(seconds: 4), () {
        Navigator.pop(context);
     });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
      Firestore.instance.collection('Payment').add({
      'dateCreated' : new DateTime.now(),
      'amount' : _amount,
      'status' : "ERROR",
      'ownerRef' : docsSnap.reference,
      'errorCode' : response.code.toString() + " - " + response.message,
      'propertyAddress' : _propertyName,
      'tenantContact' : "+91$_mobileNo",
      'tenantEmail' : _email,
      'tenantName' : _name,
    });
    Timer(Duration(seconds: 4), () {
       Navigator.pop(context);
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
    
    Firestore.instance.collection('Payment').add({
      'dateCreated' : new DateTime.now(),
      'amount' : _amount,
      'status' : "SUCCESS WALLET",
      'ownerRef' : docsSnap.reference,
      'source' : response.walletName,
      'propertyAddress' : _propertyName,
      'tenantContact' : "+91$_mobileNo",
      'tenantEmail' : _email,
      'tenantName' : _name,
    });
     Timer(Duration(seconds: 4), () {
        Navigator.pop(context);
     });
  }
}
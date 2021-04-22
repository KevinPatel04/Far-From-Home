import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfromhome/utils/responsive_screen.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:farfromhome/widgets/invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
  String _mobileNo,_name,_email,_city,_propertyName;
  double _amount;
  var _startDate, _lastDate;
  Screen size;
  DateTime _sdate,_ldate;
  Razorpay _razorpay;
  var owner;
 
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
                  labelText: 'Address *', 
                  hintText: 'Enter Rented Property Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home)
                ),
                validator: validateAddress,
                onChanged: (value) {
                  setState(() {
                    _propertyName = value;
                  });
                },
              ),
              SizedBox(
                height: size.getWidthPx(10),
              ),
               TextFormField(
                decoration: InputDecoration(
                  labelText: 'City *', 
                  hintText: 'Enter City',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(FontAwesomeIcons.mapMarkerAlt),
                ),
                validator: validateCity,
                onChanged: (value) {
                  setState(() {
                    _city = value;
                  });
                },
              ),
              SizedBox(
                height: size.getWidthPx(10),
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2018),
                    lastDate: DateTime(2025),
                  ).then<DateTime>((DateTime value){
                    if(value!=null && _lastDate==null){
                      setState((){_startDate = new DateFormat('dd-MM-yyyy').format(value);_sdate=value;});
                    }else if(value!=null && _lastDate!=null){
                      (value.difference(_sdate).inSeconds < 0) ? setState((){_startDate = new DateFormat('dd-MM-yyyy').format(value);_sdate=value;})
                       : Fluttertoast.showToast(msg: 'Start Date must be before  $_lastDate');
                    }
                  });
                },
                child:AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: _startDate == null ? 'Start Date *' : _startDate.toString(),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(FontAwesomeIcons.calendarAlt),
                    ),
                    validator: (value){
                      return _startDate==null ? 'Start date is required': null;
                    },
                  ),
                )
              ),
              SizedBox(
                height: size.getWidthPx(10),
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2018),
                    lastDate: DateTime(2025),
                  ).then<DateTime>((DateTime value){
                    if(value!=null && _startDate != null){
                      (value.difference(_sdate).inSeconds > 0) ? setState((){_lastDate = new DateFormat('dd-MM-yyyy').format(value);_ldate=value;})
                       : Fluttertoast.showToast(msg: 'Last Date must be after  $_startDate');
                      //print('Date Time = $value');
                    }else if(value!=null && _startDate==null){
                      Fluttertoast.showToast(msg: 'Select Start Date');
                    }
                  });
                },
                child:AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: _lastDate==null ? 'Last Date *' : _lastDate.toString(),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(FontAwesomeIcons.calendarAlt),
                    ),
                    validator: (value){
                      return _lastDate==null ? 'Last date is required': null;
                    },
                  ),
                )
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

  String validateAddress(String value) {
    if (value.isEmpty) return 'Address is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z0-9-,./\\[\] ]+$');
    if (!nameExp.hasMatch(value))
      return 'Address can only contain [ 0-9 A-Z a-z . - \\ / ] only';
    return null;
  }

  String validateCity(String value) {
    if (value.isEmpty) return 'City is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z0-9-,./\\[\] ]+$');
    if (!nameExp.hasMatch(value))
      return 'City can contain [ 0-9 A-Z a-z . - \\ / ] only';
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
    owner = {
      'name': docsSnap['firstName']+' '+docsSnap['lastName'],
      'mobileNo': docsSnap['mobileNo'],
      'email': docsSnap['email'],
      'address': docsSnap.data().containsKey('address') ? docsSnap['address'] : '',
      'city': docsSnap.data().containsKey('city') ? docsSnap['city'] : '',
    };
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
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    var payment = {
      'dateCreated' : new DateTime.now(),
      'amount' : _amount,
      'status' : "SUCCESS",
      'ownerRef' : docsSnap.reference,
      'paymentID' : response.paymentId,
      'mode' : 'CARD / NET BANKING',
      'city' : _city,
      'propertyAddress' : _propertyName,
      'tenantContact' : "+91$_mobileNo",
      'tenantEmail' : _email,
      'tenantName' : _name,
      'startDate' : _startDate,
      'lastDate' : _lastDate,
    };
    FirebaseFirestore.instance.collection('Payment').add(payment);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Invoice(payment,owner)));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
      var payment = {
      'dateCreated' : new DateTime.now(),
      'amount' : _amount,
      'status' : "ERROR",
      'ownerRef' : docsSnap.reference,
      'errorCode' : response.code.toString() + " - " + response.message,
      'propertyAddress' : _propertyName,
      'city' : _city,
      'tenantContact' : "+91$_mobileNo",
      'tenantEmail' : _email,
      'tenantName' : _name,
      'startDate' : _startDate,
      'lastDate' : _lastDate,
    };
    FirebaseFirestore.instance.collection('Payment').add(payment);
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Invoice(payment,owner)));
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
    var payment = {
      'dateCreated' : new DateTime.now(),
      'amount' : _amount,
      'status' : "SUCCESS",
      'ownerRef' : docsSnap.reference,
      'mode' : 'WALLET '+response.walletName,
      'city' : _city,
      'propertyAddress' : _propertyName,
      'tenantContact' : "+91$_mobileNo",
      'tenantEmail' : _email,
      'tenantName' : _name,
      'startDate' : _startDate,
      'lastDate' : _lastDate,
    };
    FirebaseFirestore.instance.collection('Payment').add(payment);
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Invoice(payment,owner)));
    Navigator.pop(context);
  }
}
import 'package:farfromhome/ui/page_home.dart';
import 'package:farfromhome/ui/page_house_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:core';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/src/asset.dart';

class AddHouse extends StatefulWidget {
  var docRef;
  AddHouse(this.docRef);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddHouseState(docRef);
  }
}

var ownerRef;

class AddHouseState extends State<AddHouse> {
  AddHouseState(val) {
    ownerRef = val;
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.blue[700],
            title: Text('Post Free House Ad'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Wall()),
    );
  }
}

List<String> _filters = <String>[];
List<String> _filter = <String>[];
final databaseReference = FirebaseFirestore.instance;
DocumentReference ref;
DocumentReference addd;
String _locality;
String _city;
String _state;
String _address;
String _pincod;
String _hono;
String _buildup;
String _monthly;
String _deposit;
String _detail;
String _beds;
String _bath;
String _ownname;
String _owndetail;
String _ownnumber;
int _value = 0;
int groupValue = 0;
String _farnistatus;
String _preferedType = "Aynone";
String _propert;
List<String> imageDataPath = <String>[];

class Wall extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WallState();
  }
}

class _WallState extends State<Wall> {
  final _formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print('_locality ${_locality}');
      print('_City ${_city}');
      print('_State ${_state}');
      print('_Address ${_address}');
      print('_ pincode ${_pincod}');
      print('_ HouseNO ${_hono}');
      //createRecord();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Secondpage()));
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
            child: Container(
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Card(
            margin: EdgeInsets.only(
                bottom: 10.0, left: 20.0, right: 20.0, top: 15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              margin: EdgeInsets.all(15.0),
              color: Colors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(
                              Icons.my_location,
                              size: 30.0,
                              color: Colors.blue[400],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'ADDRESS',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: 'Locality',
                        hintText: _locality,
                      ),
                      onSaved: (String value) {
                        if (_locality == null) {
                          _locality = value;
                        } else {
                          value = _locality;
                        }
                      },
                      autofocus: true,
                      validator: (value) =>
                          value.isEmpty ? 'Locality is required' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'City'),
                      onSaved: (String value) {
                        _city = value;
                      },
                      validator: (value) =>
                          value.isEmpty ? 'City is required' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'State'),
                      style: new TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16.0,
                      ),
                      onSaved: (String value) {
                        _state = value;
                      },
                      validator: (value) =>
                          value.isEmpty ? 'Satate is required' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'House No.'),
                      style: new TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16.0,
                      ),
                      onSaved: (String value) {
                        _hono = value;
                      },
                      validator: (value) =>
                          value.isEmpty ? 'Please Enter House Number' : null,
                    ),
                    TextFormField(
                      maxLines: 2,
                      decoration: new InputDecoration(
                        labelText: "Society Name",
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 0.0, right: 0.0),
                      ),
                      onSaved: (String value) {
                        _address = value;
                      },
                      validator: (value) =>
                          value.isEmpty ? 'Society Name  is required' : null,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Pin-Code'),
                      style: new TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16.0,
                      ),
                      onSaved: (String value) {
                        _pincod = value;
                      },
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value.isEmpty ? 'Pin Code is required' : null,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: RaisedButton(
                            onPressed: validateAndSave,
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                            elevation: 4.0,
                            color: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class Secondpage extends StatefulWidget {
  @override
  _MyFlutterAppState createState() => _MyFlutterAppState();
}

class _MyFlutterAppState extends State<Secondpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Second Page",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Post Free House Ad"),
          backgroundColor: Colors.blue[700],
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)),
        ),
        body: Inte(),
      ),
    );
  }
}

class Inte extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InteState();
  }
}

class _InteState extends State<Inte> {
  final _formKey1 = GlobalKey<FormState>();
  // String _buildup;
  // String _monthly;
  // String _deposit;

  bool validateAndSave() {
    final form = _formKey1.currentState;
    if (form.validate()) {
      form.save();
      print('_Builup ${_buildup}');
      print('_monthly rent ${_monthly}');
      print('_Deposite ${_deposit}');
      // print('_Address ${_address}');
      print('_Deposite ${_filter}');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Thirdpage()));

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey1,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[300],
          child: Card(
            margin: EdgeInsets.only(
                bottom: 10.0, left: 20.0, right: 20.0, top: 15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              color: Colors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: 20.0, left: 20.0, right: 20.0, top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      //PROPERTY TYPE
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'PROPERTY TYPE',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      //PROPERTY LIST
                      children: <Widget>[
                        //MyPropertyOptions(),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10.0, top: 5.0),
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.black,
                            child: MyPropertyOptions(),
                          ),
                        )
                        //FacilitiesFilter(),
                      ],
                    ),

                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      //FACILITYS
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'FACILITIES',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      //FACILITYS LIST
                      children: <Widget>[
                        //MyPropertyOptions(),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10.0, top: 5.0),
                            width: MediaQuery.of(context).size.width,
                            child: FacilitiesFilter(),
                          ),
                        )
                      ],
                    ),

                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      //FURNISHING STATUS
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'FURNISHING STATUS',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      //FURNISHING STATUS LIST
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                            child: MyStatefulWidget(),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      //BUILDUP AREA STATUS
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'BUILD UP AREA',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      //BUILDUP AREA STATUS ENTRY
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      decoration: new InputDecoration(
                                        hintText: 'Build Up Area in SQ.Ft',
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
                                      ),
                                      onSaved: (String value) {
                                        _buildup = value;
                                      },
                                      validator: (value) => value.isEmpty
                                          ? 'Please enter Build Up Area'
                                          : null,
                                      keyboardType: TextInputType.number,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Sq. Ft.       ",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ), //ends

                    Row(
                      //MONTHLY RENT STATUS
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'MONTHLY RENT',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      //MONTHLY RENT STATUS ENTRY
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      decoration: new InputDecoration(
                                        hintText: 'Monthly Rent in INR',
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
                                      ),
                                      onSaved: (String value) {
                                        _monthly = value;
                                      },
                                      validator: (value) => value.isEmpty
                                          ? 'Monthly Rent is required'
                                          : null,
                                      keyboardType: TextInputType.number,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Rs/Month",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ), //ends

                    Row(
                      //DEPOSIT AMOUNT RENT STATUS
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'DEPOSIT AMOUNT',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      //DEPOSIT AMOUNT STATUS ENTRY
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      decoration: new InputDecoration(
                                        hintText: 'Deposit Amount in INR',
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
                                      ),
                                      onSaved: (String value) {
                                        _deposit = value;
                                      },
                                      validator: (value) => value.isEmpty
                                          ? 'Deposit Amount is required'
                                          : null,
                                      keyboardType: TextInputType.number,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Rs              ",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ), //ends

                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: RaisedButton(
                            onPressed: validateAndSave,
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                            elevation: 4.0,
                            color: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPropertyOptions extends StatefulWidget {
  @override
  _MyPropertyOptionsState createState() => _MyPropertyOptionsState();
}

class _MyPropertyOptionsState extends State<MyPropertyOptions> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: ChoiceChip(
              pressElevation: 0.0,
              backgroundColor: Colors.grey[300],
              selectedColor: Colors.black.withOpacity(0.3),
              avatar: CircleAvatar(
                  backgroundColor: Color(0xff3ABBFA),
                  child: Image.asset(
                    'assets/icons/bunglow.png',
                    width: double.infinity,
                  )),
              label: Text(
                "Bunglow",
                style: TextStyle(
                  color: (_value == 1) ? Colors.grey.shade200 : Colors.black87,
                ),
              ),
              selected: _value == 1,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? 1 : null;
                  String apartment = 'Bunglow';
                  _propert = apartment;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: ChoiceChip(
              pressElevation: 0.0,
              backgroundColor: Colors.grey[300],
              selectedColor: Colors.grey[500],
              avatar: CircleAvatar(
                  backgroundColor: Color(0xffFBBF36),
                  child: Image.asset(
                    'assets/icons/pg.png',
                    width: double.infinity,
                  )),
              label: Text(
                "Paying Guest",
                style: TextStyle(
                  color: (_value == 2) ? Colors.grey.shade200 : Colors.black87,
                ),
              ),
              selected: _value == 2,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? 2 : null;
                  String apartment = 'PG';
                  _propert = apartment;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: ChoiceChip(
              pressElevation: 0.0,
              backgroundColor: Colors.grey[300],
              selectedColor: Colors.grey[500],
              avatar: CircleAvatar(
                backgroundColor: Color(0xff83E934),
                child: Image.asset(
                  'assets/icons/flat.png',
                  width: double.infinity,
                ),
              ),
              label: Text(
                "Apartment",
                style: TextStyle(
                  color: (_value == 3) ? Colors.grey.shade200 : Colors.black87,
                ),
              ),
              selected: _value == 3,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? 3 : null;
                  String apartment = 'Apartment';
                  _propert = apartment;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: ChoiceChip(
              pressElevation: 0.0,
              backgroundColor: Colors.grey[300],
              selectedColor: Colors.grey[500],
              avatar: CircleAvatar(
                backgroundColor: Color(0xffA7A4FC),
                child: Image.asset(
                  'assets/icons/hostel.png',
                  width: double.infinity,
                ),
              ),
              label: Text(
                "Hostel",
                style: TextStyle(
                  color: (_value == 4) ? Colors.grey.shade200 : Colors.black87,
                ),
              ),
              selected: _value == 4,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? 4 : null;
                  String apartment = 'Hostel';
                  _propert = apartment;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}

class FacilitiesFilter extends StatefulWidget {
  @override
  State createState() => FacilitiesFilterState();
}

class FacilitiesFilterState extends State<FacilitiesFilter> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('Air Conditioner', 'AC'),
    const ActorFilterEntry('Washing Machine', 'WM'),
    const ActorFilterEntry('Car Parking', 'CP'),
    const ActorFilterEntry('Wi-Fi', 'WF'),
    const ActorFilterEntry('Tiffin Facility', 'TF'),
    const ActorFilterEntry('24x7 Water Supply', 'WF'),
    const ActorFilterEntry('Garden', 'GR'),
    const ActorFilterEntry('Lift', 'LF'),
    const ActorFilterEntry('24x7 CCTV', 'CC'),
    const ActorFilterEntry('Swimming Pool', 'SP'),
    const ActorFilterEntry('Security', 'SC'),
    const ActorFilterEntry('Children Park', 'CP'),
    const ActorFilterEntry('Gym', 'GY'),
    const ActorFilterEntry('HouseKeeping', 'HK'),
    const ActorFilterEntry('Fire Safety', 'FS'),
  ];

  Iterable<Widget> get actorWidgets sync* {
    for (ActorFilterEntry actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: FilterChip(
          label: Text(
            actor.name,
            style: new TextStyle(fontSize: 11.0),
          ),
          selected: _filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(actor.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Wrap(
          children: actorWidgets.toList(),
        ),
        Text('Look for: ${_filters.join(', ')}'),
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // int groupValue=1;

  Widget build(BuildContext context) {
    return Column(
      //child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Radio(
                onChanged: (int e) => something(e),
                activeColor: Colors.blue[400],
                value: 1,
                groupValue: groupValue,
              ),
              Text(
                'Fully Furnished',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Radio(
                onChanged: (int e) => something(e),
                activeColor: Colors.blue[400],
                value: 2,
                groupValue: groupValue,
              ),
              Text(
                'Half Furnished',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Radio(
                onChanged: (int e) => something(e),
                activeColor: Colors.blue[400],
                value: 3,
                groupValue: groupValue,
              ),
              Text(
                'Not Furnished',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void something(int e) {
    setState(() {
      if (e == 1) {
        groupValue = 1;
        String apartment = 'Fully Furnished';
        _farnistatus = apartment;
      }
      if (e == 2) {
        groupValue = 2;
        String apartment = 'Half Furnished';
        _farnistatus = apartment;
      }
      if (e == 3) {
        groupValue = 3;
        String apartment = 'Not Furnished';
        _farnistatus = apartment;
      }
    });
  }
}

class Thirdpage extends StatefulWidget {
  @override
  _MyFlutterApp createState() => _MyFlutterApp();
}

class _MyFlutterApp extends State<Thirdpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Third Page",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Post Free House Ad"),
          backgroundColor: Colors.blue[700],
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)),
        ),
        body: Finalfm(),
      ),
    );
  }
}

class Finalfm extends StatefulWidget {
  Finalfm({Key key}) : super(key: key);

  @override
  _Finalfmstate createState() => _Finalfmstate();
}

class _Finalfmstate extends State<Finalfm> {
  final _formKey2 = GlobalKey<FormState>();
  // String _detail;
  // String _beds;
  // String _bath;

  bool validateAndSave() {
    final form = _formKey2.currentState;
    if (form.validate()) {
      form.save();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddImages()));
      //createRecord();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey2,
      child: Center(
        child: Container(
          color: Colors.grey[100],
          child: Card(
            margin: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              color: Colors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      //ABOUT PROPERTY STATUS
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'ABOUT PROPERTY',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      //ABOUT PRPOERTY DETAILS
                      //padding: const EdgeInsets.only(top:10.0),
                      child: TextFormField(
                        maxLines: 2,
                        autofocus: true,
                        decoration: new InputDecoration(
                          labelText: "DISCRIPTION",
                          hintText: 'Discribe your property',
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(10.0),
                        ),
                        onSaved: (String value) {
                          _detail = value;
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return "Description cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      //DEPOSIT AMOUNT RENT STATUS
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'NO. OF BEDROOMS',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      //NO OF BEDROOMS ENTRY
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      decoration: new InputDecoration(
                                        //labelText: 'No. of Bedrooms',
                                        hintText: 'Enter No of Bedrooms',
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                      ),
                                      onSaved: (String value) {
                                        _beds = value;
                                      },
                                      validator: (value) => value.isEmpty
                                          ? 'No. of Bedrooms is required'
                                          : null,
                                      keyboardType: TextInputType.number,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      //DEPOSIT AMOUNT RENT STATUS
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'NO. OF BATHROOMS',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      //NO OF BATHROOMS ENTRY
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      decoration: new InputDecoration(
                                        //labelText: "No. of Bathrooms",
                                        hintText: 'Enter No Of Bathrooms',
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.all(15.0),
                                      ),
                                      onSaved: (String value) {
                                        _bath = value;
                                      },
                                      validator: (value) => value.isEmpty
                                          ? 'No. of Bathroom is required'
                                          : null,
                                      keyboardType: TextInputType.number,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: const BoxDecoration(),
                          ),
                        )
                      ],
                    ),
                    Row(
                      //TYPESOFTANENT STATUS
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: new EdgeInsets.fromLTRB(0, 0, 0, 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: Colors.blue[400],
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'TYPES OF TENANT EXPECTING',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Tentype(),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: RaisedButton(
                            onPressed: validateAndSave,
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                            elevation: 6.0,
                            color: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool stdVal = false;
bool baVal = false;
bool boyVal = false;
bool girlVal = false;
bool anyVal = false;

class Tentype extends StatefulWidget {
  @override
  _TentypeState createState() => _TentypeState();
}

class _TentypeState extends State<Tentype> {
  // bool stdVal = false;
  // bool baVal = false;
  // bool boyVal = false;
  // bool girlVal = false;
  // bool anyVal = true;

  /// box widget
  /// [title] is the name of the checkbox
  /// [boolValue] is the boolean value of the checkbox
  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            //Text(title),
            Checkbox(
              value: boolValue,
              onChanged: (bool value) {
                /// manage the state of each value
                setState(() {
                  switch (title) {
                    case "Students":
                      stdVal = value;
                      _preferedType = "Students";
                      break;
                    case "Bachelors":
                      baVal = value;
                      _preferedType = "Bachelors";
                      break;
                    case "Boys Only":
                      boyVal = value;
                      _preferedType = "Boys Only";
                      break;
                    case "Girls Only":
                      girlVal = value;
                      _preferedType = "Girls Only";
                      break;
                    case "Anyone":
                      anyVal = value;
                      _preferedType = "Anyone";
                      break;
                  }
                });
              },
            ),
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              checkbox("Students", stdVal),
              checkbox("Bachelors", baVal),
              checkbox("Boys Only", boyVal),
              checkbox("Girls Only", girlVal),
              checkbox("Anyone", anyVal),
            ],
          ),
        ],
      ),
    );
  }
}

var _status = true;
var _uploadStatus = false;
var _isImageSelected = false;
// void main() {
//   runApp(MaterialApp(
//     title: 'Address',
//     home: AddImages(),
//   ));
// }

class AddImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiImage(),
    );
  }
}

void createRecord(context) async {
  var address = {
    'locality': _locality,
    'city': _city,
    'state': _state,
    'society': _address,
    'pincode': _pincod,
    'houseNo': _hono
  };
  var overview = {
    'bathroom': _bath,
    'room': _beds,
    'furnishingStatus': _farnistatus,
    'propertyType': _propert,
    'preferedType': _preferedType
  };
  ref = await databaseReference.collection("House")
      // .document("1")
      .add({
    'Address': address,
    'Date Created': DateTime.now(),
    'Date Updated': DateTime.now(),
    'Facilities': _filters,
    'Overview': overview,
    'favourite': 0,
    'houseImages': imageDataPath,
    'builtUpArea': _buildup,
    'depositAmount': _deposit,
    'description': _detail,
    'monthlyRent': _monthly,
    'ownerDetail': '/User/' + userReference.toString(),
    'status': 'Available'
  });
  print(ref.id);
  Navigator.pop(context);
  Navigator.pop(context);
  Fluttertoast.showToast(msg: 'House Ad Posted Successfully');
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => SearchPage()));
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Upload', icon: Icons.cloud_upload),
  const Choice(title: 'Post House Deal', icon: Icons.check)
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}

class MultiImage extends StatefulWidget {
  @override
  _MultiImageState createState() => new _MultiImageState();
}

class _MultiImageState extends State<MultiImage> {
  List<Asset> images = List<Asset>();
  List<String> imagePaths = List<String>();
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  String filePath;
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  //var imageDataPath = { };
  int i = 0, len;
  Future<Null> _addImages(var pic) async {
    var t = await pic.filePath;
    File file = new File(t);
    filePath = '${DateTime.now()}.png';
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.refFromURL('gs://farfromhome-2019.appspot.com/').child(filePath);
    UploadTask task = ref.putFile(file);
    TaskSnapshot storageTaskSnapshot = await task.whenComplete(() => null);
    String url = await storageTaskSnapshot.ref.getDownloadURL();

    print("\nUploaded: " + url);
    //Download URL's
    //imageDataPath[i] = url;
    setState(() {
      imageDataPath.add(url);
      i++;
    });
    if (len == i + 1) {
      setState(() {
        _status = !_status;
        _uploadStatus = !_uploadStatus;
      });
    }
  }

  //Uploading images
  Future<Null> _uploadImages() {
    setState(() {
      len = images.length;
      _uploadStatus = !_uploadStatus;
    });
    images.forEach((pic) {
      _addImages(pic);
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#1972d2",
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      for (var r in resultList) {
        var t = await r.name;
        //print(t);
      }
      if (resultList.isNotEmpty) {
        setState(() {
          _isImageSelected = true;
        });
      } else {
        setState(() {
          _isImageSelected = false;
        });
      }
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("Add House Images"),
          backgroundColor: Colors.blue[700],
          actions: _isImageSelected
              ? <Widget>[
                  // action button
                  _status
                      ? IconButton(
                          icon: Icon(choices[0].icon),
                          onPressed: () {
                            _uploadImages();
                          },
                        )
                      : IconButton(
                          icon: Icon(choices[1].icon),
                          onPressed: () {
                            print('Saved');
                            createRecord(context);
                            //upload code here here
                          },
                        ),
                ]
              : null,
        ),
        body: _uploadStatus
            ? Center(child: new CircularProgressIndicator())
            : new Column(
                children: <Widget>[
                  Expanded(
                    child: buildGridView(),
                  ),
                ],
              ),
        floatingActionButton: _status
            ? FloatingActionButton(
                onPressed: () {
                  loadAssets();
                },
                child: Icon(Icons.add_a_photo),
                backgroundColor: Colors.blue[700],
              )
            : null,
      ),
    );
  }
}

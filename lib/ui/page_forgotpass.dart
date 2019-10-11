import 'package:farfromhome/ui/page_login.dart';
import 'package:flutter/material.dart';
import 'package:farfromhome/widgets/widgets.dart';
import 'package:farfromhome/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  bool isLoading = false;

  Screen size;

  bool validateAndSave() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      print("Email:: $_email");
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {

      try {
        FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        print("Password reset email sent");
        Fluttertoast.showToast(msg: "Reset password link is send to your registered email");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginPage()));
      }
      catch (e){
        print("Error at forgot password ::   $e");
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Container(
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
        top: true,
        child: Scaffold(
          appBar: AppBar(
              elevation: 0.0,
              primary: false,
              centerTitle: true,
             backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: colorCurve,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
          ),
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: false,

            body: Stack(children: <Widget>[
              Center(
                child: SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _forgotGradientText(),
                    SizedBox(height: size.getWidthPx(24)),
                    Header(),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.getWidthPx(16)),
                        child: _emailFeild())
                  ],
                ),
              ),
                ),
              )
            ])),
      ),
    );
  }

  Header() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _passwordIconWidget(),
          SizedBox(height: size.getWidthPx(24)),
          Text(
            "Please fill your details below",
            style: TextStyle(
                fontSize: size.hp(2),
                fontStyle: FontStyle.normal),
          ),
        ],
      );

  GradientText _forgotGradientText() {
    return GradientText('Forgot password',
        gradient: LinearGradient(colors: [
          Colors.blue[700],
          Colors.blue[700]
        ]),
        style: TextStyle(
          fontFamily: 'Exo2', fontSize: size.wp(10), fontWeight: FontWeight.bold));
  }

  CircleAvatar _passwordIconWidget() {
    return CircleAvatar(
      maxRadius: size.getWidthPx(82),
      child: Image.asset("assets/icons/imgforgot.png"),
      backgroundColor: colorCurve,
    );
  }

  BoxField _emailWidget() {
    return BoxField(
      hintText: "Enter email",
      lableText: "Email",
      obscureText: false,
      onSaved: (value) => _email = value,
      validator: validateEmail,
      icon: Icons.email,
      iconColor: colorCurve,
    );
  }

  _emailFeild() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _emailWidget(),
          SizedBox(height: size.getWidthPx(20)),
          _submitButtonWidget(),
        ],
      );

  Container _submitButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: RaisedButton(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(size.getWidthPx(12)),
        child: Text(
          "Submit",
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
        ),
        color: colorCurve,
        onPressed: () {
          // Validate Email First
          validateAndSubmit();
        },
      ),
    );
  }

  String validateEmail(String value) {
    RegExp regExp = RegExp(Constants.PATTERN_EMAIL, caseSensitive: false);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter valid email address.";
    }
    return null;
  }

}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:farfromhome/main.dart';
import 'package:farfromhome/Authentication.dart';


class Routes{

  Route _createLoginRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>  LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

Route _createSignupRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  SignupPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

}
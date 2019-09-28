import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_container/responsive_container.dart';

Widget loader(){
  return Scaffold(
    body: ResponsiveContainer(
      widthPercent: 100,
      heightPercent: 100,
      child: Container(
        color: Color(0xfff8f5f0),    // white color
        //color: Color(0xff1869d9),  // blue color
        child: Image.asset(
          'assets/gif/city.gif'         // white gif
          //'assets/gif/city_blue.gif'  // blue gif
          ),
        ),
      ),
  );
}

Widget search_loader(){
  return Scaffold(
    body: ResponsiveContainer(
      widthPercent: 100,
      heightPercent: 100,
      child: Container(
        color: Color(0xffeaebed),    // white color
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/gif/search_loading.gif'
              ),
          ],
        ),
        ),
      ),
  );
}
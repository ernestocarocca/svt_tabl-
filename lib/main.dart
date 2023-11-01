import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/main.dart';
import 'package:svt_tabla/dateconverter.dart';
import 'package:svt_tabla/pages/home_page.dart';
import 'package:svt_tabla/pages/pagetimetableList.dart';
import 'package:svt_tabla/show_tabl.dart';
import 'package:svt_tabla/tablaObject.dart';
import 'package:intl/intl.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    MyHomePage2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: PageController(initialPage: currentPageIndex),
          children: pages,
          onPageChanged: (index) {
            setState(() {
              currentPageIndex = index;
              if (currentPageIndex == 1) {
                setState(() {
                  MyHomePage2();
                });
              } else {
                setState(() {
                  HomePage();
                });
              }
            });
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.holiday_village),
            label: 'Radios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.holiday_village),
            label: 'Camera',
          ),
        ],
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
            print('hej');
            print(currentPageIndex);
          });
        },
      ),
    );
  }
}

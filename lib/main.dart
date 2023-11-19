import 'package:flutter/material.dart';
import 'package:svt_tabla/fetch_handler/fetchhandler.dart';
import 'package:svt_tabla/pages/home_page.dart';
import 'package:svt_tabla/pages/pagetimetableList.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int currentIndex = 0;
  FetchTimeTable getRadioStation = FetchTimeTable();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Vx.orange600,
              Vx.purple500,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_fill_sharp),
              label: 'Radio Play',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.radio_rounded),
              label: 'Radio Tablå',
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomePage(), // Add your HomePage widget here
          MyHomePage2(), // Add your MyHomePage2 widget here
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:svt_tabla/pages/home_page.dart';
import 'package:svt_tabla/pages/pagetimetableList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        drawer: const Drawer(),
        bottomNavigationBar: NavigationBar(
          surfaceTintColor: Colors.amber,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.play_circle_fill_sharp), label: 'Radio Play'),
            NavigationDestination(
              icon: Icon(Icons.radio_rounded),
              label: 'Radio Tablå',
            ),
          ],
          selectedIndex: currentIndex,
          onDestinationSelected: (int index) {
            setState(
              () {
                currentIndex = index;
              },
            );
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
        body: [HomePage(), MyHomePage2()][currentIndex]);
  }
}

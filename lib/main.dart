import 'package:flutter/material.dart';
import 'package:svt_tabla/fetch_handler/fetchhandler.dart';
import 'package:svt_tabla/pages/home_page.dart';
import 'package:svt_tabla/pages/pagetimetableList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: //RadioPlayerPage(),
          MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  Duration position = Duration.zero;
  int currentIndex = 0;
  List<dynamic> channelsData = [];
  FetchTimeTable getRadioStation = FetchTimeTable();

  void fetchData() async {
    final data = await getRadioStation.fetchDataRadio();
    if (data != null) {
      setState(() {
        channelsData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: NavigationBar(
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

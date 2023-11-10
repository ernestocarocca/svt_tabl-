import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svt_tabla/ai_util.dart';
import 'package:svt_tabla/fetch_handler/fetchhandler.dart';
import 'package:svt_tabla/pages/audioplayer.dart';
import 'package:svt_tabla/pages/home_page.dart';
import 'package:svt_tabla/pages/pagetimetableList.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(MyApp());
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
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(20),
            // padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              //padding: EdgeInsets.zero,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'asset/assets/radio.jpg',
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                    )),
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Radio lista'),
                  onTap: () {
                    setState(() {
                      fetchData();
                    });
                  },
                ),
                ListTile(
                  title: const Text('Radiolist'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
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

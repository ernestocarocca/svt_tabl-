import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_tabla/dateconverter.dart';
import 'package:svt_tabla/show_tabl.dart';
import 'package:svt_tabla/tablaObject.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'svt tablå',
      home: MyHomePage(
        title: 'timetablet',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> scheduleData = [];

  @override
  void initState() {
    super.initState();

    fetchData().then((data) {
      setState(() {
        scheduleData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.network(
            'https://static-cdn.sr.se/images/166/1cf8d86c-bcca-4b20-ab83-9b8a7e2e75f2.jpg?preset=2048x1152',
            fit: BoxFit.cover, // Justera höjden efter ditt behov
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.network(
                'https://static-cdn.sr.se/images/166/1cf8d86c-bcca-4b20-ab83-9b8a7e2e75f2.jpg?preset=2048x1152',
                width: 45, // Justera bredden efter ditt behov
                height: 45, // Justera höjden efter ditt behov
              ),
              label: 'Radio',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.holiday_village),
              label: 'Camera',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: scheduleData.length,
          itemBuilder: (context, index) {
            var item = scheduleData[index];
            dynamic apiDate = item['starttimeutc'];
            dynamic formattedDate = formatApiDate(apiDate);

            Tablaobject tablaObject = Tablaobject(item['program']['name'],
                item['description'], formattedDate, item['imageurltemplate']);
            return ShowTabl(
              timeTable: tablaObject,
              formattedDate: formattedDate,
            );
          },
        ));
  }
}

Future<List<dynamic>> fetchData() async {
  var getFetchUrl = "https://api.sr.se/v2/scheduledepisodes?channelid=158";
  String date = "&date=2018-09-25";
  String json = "&format=json";
  final dio = Dio();
  try {
    final response = await dio.get(getFetchUrl + date + json);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      List<dynamic> schedule = data['schedule'];
      return schedule;
    } else {
      throw Exception('Failed to load data from the API');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

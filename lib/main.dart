import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_tabla/show_tabl.dart';
import 'package:svt_tabla/tablaObject.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'svt tablå',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const MyHomePage(
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
        title: const Text('Svt Tablå'),
      ),
      body: ListView.builder(
        itemCount: scheduleData.length,
        itemBuilder: (context, index) {
          var item = scheduleData[index];
          // Create a TablaObject from your data,
          Tablaobject tablaObject = Tablaobject(item['program']['name'],
              item['description'], "date", false, item['imageurltemplate']);
          return ShowTabl(timeTable: tablaObject);
        },
      ),
    );
  }
}

Future<List<dynamic>> fetchData() async {
  var getFetchUrl = "https://api.sr.se/v2/scheduledepisodes?channelid=158&";
  String date = "2017-09-25&";
  String json = "format=json";
  final dio = Dio();
  try {
    final response = await dio.get(
      getFetchUrl + date + json,
    );

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

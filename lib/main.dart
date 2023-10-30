import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_tabla/showTabl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'svt tablå',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(
        title: 'timetablet',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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

          return ListTile(
              title: Text(item['title']),
              leading: item['imageurltemplate'] != null
                  ? Image.network(item['imageurltemplate'])
                  : const Icon(Icons
                      .image_not_supported), // Visa ikon om ingen bild finns

              subtitle: Column(
                children: [
                  Text(item['description']),
                  Text(item['program']['name']),
                  Text("Starttid: ${item['starttimeutc']}"),
                  Text("Sluttid: ${item['endtimeutc']}"),
                ],
              ));
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

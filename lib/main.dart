import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_tabla/showTabl.dart';
import 'package:svt_tabla/tablaObject.dart';

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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> scheduleData = [];
  final List<TablaObject> _post = [
    TablaObject(
      "p4",
      "Senaste nyheterna varje timme från Ekot.",
      DateTime.now(),
      false,
      Image.network(
        'https://static-cdn.sr.se/images/3117/76f4b1be-4472-4571-b0c0-ba6a08ce1f8f.jpg?preset=2048x1152&format=webp',
        cacheHeight: 100,
      ),
    ),
  ];

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
          title: const Text("Svt Tablå"),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            backgroundColor: Colors.purple,
            fontSize: 20.0,
          ),
        ),
        body: ListView.builder(
            itemCount: scheduleData.length,
            itemBuilder: (context, index) {
              var item = scheduleData[index];
              return ListTile(
                title: Text(item['title']),
                subtitle: Text(item['description']),
                leading: item['imageurl'] != null
                    ? Image.network(item['imageurl'])
                    : const Icon(Icons
                        .image_not_supported), // Visa ikon om ingen bild finns
              );
            }));
  }
}

Future<List<dynamic>> fetchData() async {
  final dio = Dio();
  try {
    final response = await dio.get(
      'http://api.sr.se/api/v2/scheduledepisodes?channelid=164&format=json',
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

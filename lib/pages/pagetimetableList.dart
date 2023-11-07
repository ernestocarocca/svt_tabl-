import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_tabla/ai_util.dart';
import 'package:svt_tabla/dateconverter.dart';
import 'package:svt_tabla/fetch_handler/fetchhandler.dart';
import 'package:svt_tabla/show_tabl.dart';
import 'package:svt_tabla/tablaObject.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:glassmorphism/glassmorphism.dart';

class MyHomePage2 extends StatefulWidget {
  @override
  State<MyHomePage2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  List<dynamic> scheduleData = [];
  FetchTimeTable _apiService = FetchTimeTable();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final data = await _apiService.fetchDataTimeTable();
      if (data != null) {
        print("Fetched data: $data"); // Skriv ut data från API-anropet
        setState(() {
          scheduleData = data;
        });
      } else {
        print("Data is null");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
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
      body: Container(
        /*
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AIColors.primaryColor1, AIColors.primaryColor2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),*/
        child: ListView.builder(
          itemCount: scheduleData.length,
          itemBuilder: (context, index) {
            var item = scheduleData[index];
            dynamic apiDate = item['starttimeutc'];
            List<String> YearMonthDayhourMinResul = formatApiDate(apiDate);
            String formattedTime = YearMonthDayhourMinResul[1];
            String formatDate = YearMonthDayhourMinResul[0];
            Tablaobject tablaObject = Tablaobject(
                item['program']['name'],
                item['description'],
                formattedTime,
                formatDate,
                item['imageurltemplate']);
            return ShowTabl(timeTable: tablaObject);
          },
        ),
      ),
    );
  }
}

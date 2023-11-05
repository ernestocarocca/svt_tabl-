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
    // fetchData().then((data) {
    // setState(() {
    // scheduleData = data;
    //});
    //});
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AIColors.primaryColor1, AIColors.primaryColor2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: scheduleData.length,
          itemBuilder: (context, index) {
            var item = scheduleData[index];
            dynamic apiDate = item['starttimeutc'];
            dynamic formattedDate = formatApiDate(apiDate);
            Tablaobject tablaObject = Tablaobject(item['program']['name'],
                item['description'], formattedDate, item['imageurltemplate']);
            return GlassmorphicContainer(
              margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              borderRadius: 10.0, // Anpassa radien efter dina behov
              blur: 10,
              alignment: Alignment.center,
              border: 4.5,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.transparent, Colors.transparent],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.transparent, Colors.transparent],
              ),
              width: 100,
              height: 100,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    // Vit färg för border
                     // Justera tjockleken efter dina behov
                  ),
                ),
                child: ShowTabl(timeTable: tablaObject),
              ),
            );
          },
        ),
      ),
    );
  }
}

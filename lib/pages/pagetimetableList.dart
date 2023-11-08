import 'package:dio/dio.dart';
import 'package:filter_list/filter_list.dart';
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
  List<dynamic> scheduleDataList = [];
  List<dynamic> scheduleDataList2 = [];
  List<dynamic> scheduleDataListPast = [];
  List<dynamic> addtolist = [];
  FetchTimeTable _apiServicePast = FetchTimeTable();
  FetchTimeTable _apiServiceCurrentDay = FetchTimeTable();
  FetchTimeTable _apiServiceFuture = FetchTimeTable();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final data = await _apiServiceCurrentDay.fetchDataTimeTable();
      final data2 = await _apiServiceFuture
          .fetchDataTimeTableFuture(); // fetch furure date
      final data3 =
          await _apiServicePast.fetchDataTimeTablePast(); // fetch past date

      if (data != null) {
        setState(() {
          scheduleDataListPast = data3;
          addtolist.addAll(scheduleDataListPast);
          scheduleDataList = data;
          addtolist.addAll(scheduleDataList);
          scheduleDataList2 = data2;
          addtolist.addAll(scheduleDataList2);

          print(addtolist.length);

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
          itemCount: addtolist.length,
          itemBuilder: (context, index) {
            var item = addtolist[index];
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
      floatingActionButton: ElevatedButton(
          onPressed: () {
            fetchData();
          },
          child: Text('fetchahär')),
    );
  }
}

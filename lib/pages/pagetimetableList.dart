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
  List<dynamic> scheduleDataListPast = [];
  List<dynamic> fetchedData = [];
  List<dynamic> scheduleDataListFuture = [];
  DateTime date = DateTime.now();
  bool isTop = false;
  List<dynamic> listToShow = [];
  FetchTimeTable _apiServiceCurrentDay = FetchTimeTable();
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 50, keepScrollOffset: true);
  double scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        isTop = _scrollController.position.pixels == 0;
        if (isTop) {
          setState(() {
            

            print(scrollPosition);
            var item = listToShow.first;
         
            dynamic apiDate = item['starttimeutc'];
            List<String> YearMonthDayhourMinResul = formatApiDate(apiDate);
            String formatDate = YearMonthDayhourMinResul[0];
            var parseDate = DateTime.parse(formatDate);
            date = parseDate;
            print(parseDate);

            date = date.subtract(Duration(days: 1));
          });

          print(date);

          fetchData();
          print('At the top');
        } else {
          setState(() {
            var item = listToShow.last;
            dynamic apiDate = item['starttimeutc'];
            List<String> YearMonthDayhourMinResul = formatApiDate(apiDate);
            String formatDate = YearMonthDayhourMinResul[0];
            var parseDate = DateTime.parse(formatDate);
            date = parseDate;
            print(parseDate);

            date = date.add(Duration(days: 1));
          });
          fetchData();
          print('At the bottom');
          print(scrollPosition);
        }
      }
    });
    fetchData();
  }

  void fetchData() async {
    try {
      final dataCurrentDate =
          await _apiServiceCurrentDay.fetchDataTimeTable(date);

      //  final data3 =
      //    await _apiServicePast.fetchDataTimeTablePast(); // fetch past date

      if (dataCurrentDate != null) {
        setState(() {
          fetchedData = dataCurrentDate;
          if (isTop) {
            print('isTop');
            print(fetchedData.length);
            fetchedData.addAll(listToShow);

            listToShow = fetchedData;

            print(fetchedData.length);
          } else {
            print('not is top');
            print(listToShow.length);
            listToShow.addAll(fetchedData);
            print(listToShow);
          }

          // scheduleData = dataCurrentDate;
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
        child: ListView.builder(
          controller: _scrollController,
          itemCount: listToShow.length,
          itemBuilder: (context, index) {
            var item = listToShow[index];
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


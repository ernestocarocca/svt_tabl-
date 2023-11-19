import 'package:flutter/material.dart';
import 'package:svt_tabla/dateconverter.dart';
import 'package:svt_tabla/fetch_handler/fetchhandler.dart';
import 'package:svt_tabla/show_tabl.dart';
import 'package:svt_tabla/tablaObject.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key});

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
  final FetchTimeTable _apiServiceCurrentDay = FetchTimeTable();
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 50, keepScrollOffset: true);
  double scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
// Controls if scroll is on top or button to fetch yesterday's or tomorrow's radio.

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        isTop = _scrollController.position.pixels == 0;
        if (isTop) {
          setState(() {
            var item = listToShow.first;

            dynamic apiDate = item['starttimeutc'];
            List<String> yearMonthDayhourMinResul = formatApiDate(apiDate);
            String formatDate = yearMonthDayhourMinResul[0];
            var parseDate = DateTime.parse(formatDate);
            date = parseDate;

            date = date.subtract(const Duration(days: 1));
          });

          fetchData();
          print('At the top');
        } else {
          setState(() {
            var item = listToShow.last;
            dynamic apiDate = item['starttimeutc'];
            List<String> yearMonthDayhourMinResul = formatApiDate(apiDate);
            String formatDate = yearMonthDayhourMinResul[0];
            var parseDate = DateTime.parse(formatDate);
            date = parseDate;
            date = date.add(const Duration(days: 1));
          });
          fetchData();
          print('At the bottom');
        }
      }
    });
    fetchData();
  }

  void fetchData() async {
    try {
      final dataCurrentDate =
          await _apiServiceCurrentDay.fetchDataTimeTable(date);

      if (dataCurrentDate != null) {
        setState(() {
          fetchedData = dataCurrentDate;
          if (isTop) {
            print('isTop');

            fetchedData.addAll(listToShow);

            listToShow = fetchedData;
          } else {
            print('not is top');
            listToShow.addAll(fetchedData);
          }
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
          fit: BoxFit.cover,
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: listToShow.length,
        itemBuilder: (context, index) {
          var item = listToShow[index];
          dynamic apiDate = item['starttimeutc'];
          List<String> yearMonthDayhourMinResul = formatApiDate(apiDate);
          String formattedTime = yearMonthDayhourMinResul[1];
          String formatDate = yearMonthDayhourMinResul[0];
          Tablaobject tablaObject = Tablaobject(
              item['program']['name'],
              item['description'],
              formattedTime,
              formatDate,
              item['imageurltemplate']);
          return ShowTabl(timeTable: tablaObject);
        },
      ),
    );
  }
}

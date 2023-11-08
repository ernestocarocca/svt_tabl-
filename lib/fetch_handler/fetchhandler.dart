import 'dart:math';

import 'package:dio/dio.dart';

// fetchar from svtRadio api
class FetchTimeTable {
  // fetch timetable from one radiostation

  Future<List<dynamic>> fetchDataTimeTable() async {
    var getFetchUrl = "https://api.sr.se/v2/scheduledepisodes?channelid=158";
    //  String date = "&date=2018-09-25";
    String json = "&format=json";

    DateTime now = DateTime.now();
    String date = DateTime(now.year, now.month, now.day)
        .toString()
        .replaceAll("00:00:00.000", "");
    date = '&date=$date'.trim();

    getFetchUrl = getFetchUrl + date + json;

    final dio = Dio();
    try {
      Response response = await dio.get(getFetchUrl);

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

  Future<List<dynamic>> fetchDataRadio() async {
    // fetch all radiostaion from svt radio
    var getFetchUrl = "http://api.sr.se/api/v2/channels?&format=json";
    String date = "&date=2018-09-25";
    String json = "&format=json";
    final dio = Dio();
    try {
      final response = await dio.get(getFetchUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        List<dynamic> channels = data['channels'];
        return channels;
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<dynamic>> fetchDataP2() async {
    // fetch all radiostaion from svt radio
    var fetchP2 =
        ' http://api.sr.se/api/v2/programs/index?channelid=163&format=json';
    String date = "&date=2018-09-25";
    String json = "&format=json";
    final dio = Dio();
    try {
      final response = await dio.get(fetchP2);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        List<dynamic> programs = data['programs'];
        return programs;
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  Future<List<dynamic>> fetchDataTimeTableFuture() async {
    var getFetchUrl = "https://api.sr.se/v2/scheduledepisodes?channelid=158";
    //  String date = "&date=2018-09-25";
    String json = "&format=json";

    DateTime now = DateTime.now().add(Duration(days: 1));
    String date = DateTime(now.year, now.month, now.day)
        .toString()
        .replaceAll("00:00:00.000", "");
    date = '&date=$date'.trim();

    getFetchUrl = getFetchUrl + date + json;

    final dio = Dio();
    try {
      final response = await dio.get(getFetchUrl);

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
  Future<List<dynamic>> fetchDataTimeTablePast() async {
    var getFetchUrl = "https://api.sr.se/v2/scheduledepisodes?channelid=158";
    //  String date = "&date=2018-09-25";
    String json = "&format=json";

    DateTime now = DateTime.now().subtract(Duration(days: 1));
    String date = DateTime(now.year, now.month, now.day)
        .toString()
        .replaceAll("00:00:00.000", "");
    date = '&date=$date'.trim();

    getFetchUrl = getFetchUrl + date + json;

    final dio = Dio();
    try {
      final response = await dio.get(getFetchUrl);

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
}

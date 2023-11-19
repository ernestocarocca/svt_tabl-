

import 'package:dio/dio.dart';

// fetchar from svtRadio api
class FetchTimeTable {
  // fetch timetable from one radiostation

  Future<List<dynamic>> fetchDataTimeTable(DateTime date) async {
    var getFetchUrl = "https://api.sr.se/v2/scheduledepisodes?channelid=158";
    //  String date = "&date=2018-09-25";
    String json = "&format=json";

    String formattedDate = DateTime(date.year, date.month, date.day)
        .toString()
        .replaceAll("00:00:00.000", "");
    formattedDate = '&date=$formattedDate'.trim();

    getFetchUrl = getFetchUrl + formattedDate + json;

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
    //var getRadioUrlTemplate
    // fetch all radiostaion from svt radio
    var getFetchUrl = "http://api.sr.se/api/v2/channels?&format=json";

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
}

import 'package:dio/dio.dart';

class FetchTimeTable {
  Future<List<dynamic>> fetchDataTimeTable() async {
    var getFetchUrl = "https://api.sr.se/v2/scheduledepisodes?channelid=158";
    String date = "&date=2018-09-25";
    String json = "&format=json";
    final dio = Dio();
    try {
      final response = await dio.get(getFetchUrl + date + json);

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
}

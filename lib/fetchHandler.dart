import 'package:dio/dio.dart';

class FetchHandler {
  List<String> timeTableList = ["hej"];
  final Dio dio = Dio();
  void fetchData() async {
    Response response = await dio.get(
        'http://api.sr.se/api/v2/scheduledepisodes?channelid=164&format=json');
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<String> timeTableList =
          data.map((item) => item['text'].toString()).toList();
    } else {
      throw Exception("ring ayo knas bror");
    }
  }
}

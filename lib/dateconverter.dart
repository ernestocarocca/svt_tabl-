import 'package:intl/intl.dart';

List<String> formatApiDate(String apiDate) {
  final YearMd = 'yyyy-MM-dd';
  final hourMin = 'HH:mm';
  int timestamp = int.parse(apiDate.replaceAll(RegExp(r'[^0-9]'), ''));
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final formattedTime = DateFormat(YearMd).format(dateTime);
  final formattedDate = DateFormat(hourMin).format(dateTime);
  return [formattedTime,formattedDate];
}

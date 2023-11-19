import 'package:intl/intl.dart';

// Convert time to the format so it can be readable.
List<String> formatApiDate(String apiDate) {
  const yearMd = 'yyyy-MM-dd';
  const hourMin = 'HH:mm';
  int timestamp = int.parse(apiDate.replaceAll(RegExp(r'[^0-9]'), ''));
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final formattedTime = DateFormat(yearMd).format(dateTime);
  final formattedDate = DateFormat(hourMin).format(dateTime);
  return [formattedTime, formattedDate];
}

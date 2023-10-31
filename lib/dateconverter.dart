import 'package:intl/intl.dart';

String formatApiDate(String apiDate) {
  int timestamp = int.parse(apiDate.replaceAll(RegExp(r'[^0-9]'), ''));
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

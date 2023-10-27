import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TablaObject {
  String timetableName = "P4";
  DateTime myDateTime;
  late DateFormatter dateFormatter;
  String slogan = "Senaste nyheterna varje timme från Ekot.";
  bool onLive = false;
  Image image;

  TablaObject(this.timetableName, this.slogan, this.myDateTime, this.onLive,
      this.image) {
    dateFormatter = DateFormatter(myDateTime);
  }
}

class DateFormatter {
  DateTime myDateTime;

  DateFormatter(this.myDateTime);

  String format(String formatPattern) {
    return DateFormat(formatPattern).format(myDateTime);
  }
}

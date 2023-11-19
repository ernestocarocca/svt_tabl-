import 'package:flutter/material.dart';

class Tablaobject {
  String timetableName;
  String date;
  String time;
  String radioUrl;
  String imageUrl;

  final GlobalKey backgroundImagekey = GlobalKey();

  Tablaobject(
    this.timetableName,
    this.date,
    this.time,
    this.radioUrl,
    this.imageUrl,
  );

  String? getImage() {
    return imageUrl;
  }

  DateTime? geTimeInDateTime() {
    return DateTime.parse(time);
  }

  String? getRadioUrl() {
    return radioUrl;
  }
}

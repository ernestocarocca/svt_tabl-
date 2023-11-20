import 'package:flutter/material.dart';

class Tablaobject {
  String timetableName;
  String date;
  String time;
  String description;
  String radioUrl;
  String imageUrl;
  Tablaobject(this.timetableName, this.date, this.time, this.description,
      this.radioUrl, this.imageUrl);

  final GlobalKey backgroundImagekey = GlobalKey();

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

// ignore: file_names
import 'package:flutter/material.dart';

class Tablaobject {
  String timetableName;
  String date;
  String slogan;
  String imageUrl;
  final GlobalKey backgroundImagekey = GlobalKey();

  Tablaobject(this.timetableName, this.slogan, this.date, this.imageUrl);
}

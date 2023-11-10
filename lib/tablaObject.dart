// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Tablaobject {
  String timetableName;
  String date;
  String time;
  String slogan;
  String imageUrl;

  final GlobalKey backgroundImagekey = GlobalKey();

  Tablaobject(
    this.timetableName,
    this.date,
    this.time,
    this.slogan,
    this.imageUrl,
  );
}

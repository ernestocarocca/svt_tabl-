// ignore: file_names
import 'package:flutter/material.dart';
import 'package:svt_tabla/ai_util.dart';
import 'package:svt_tabla/tablaObject.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:filter_list/filter_list.dart';

class ShowTabl extends StatelessWidget {
  //final String formattedDate;
  final dynamic child;
  final Tablaobject timeTable;
  const ShowTabl({
    super.key,
    required this.timeTable,
    this.child,
  });
  // required this.formattedDate
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'TimeTable Name: ${timeTable.timetableName} ',
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            'Slogan: ${timeTable.slogan} ',
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            "date: ${timeTable.date}",
            style: const TextStyle(color: Colors.black),
          ),
          Flexible(
            child: Image.network(
              timeTable.imageUrl,
              height: 45,
              width: 45,
            ),
          ) // Visa bilden här
        ],
      )),
    );
  }
}

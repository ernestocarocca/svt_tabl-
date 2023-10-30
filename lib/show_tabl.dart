// ignore: file_names
import 'package:flutter/material.dart';
import 'package:svt_tabla/tablaObject.dart';

class ShowTabl extends StatelessWidget {
  final dynamic child;
  final Tablaobject timeTable;
  const ShowTabl({super.key, required this.timeTable, this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 200,
        color: Colors.black,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TimeTable Name: ${timeTable.timetableName} ',
              style: const TextStyle(color: Colors.amber),
            ),
            Text(
              'Slogan: ${timeTable.slogan} ',
              style: const TextStyle(color: Colors.white),
            ),

            Flexible(
              child: Image.network(
                timeTable.imageUrl,
                fit: BoxFit.contain,
              ),
            ) // Visa bilden här
          ],
        )),
      ),
    );
  }
}

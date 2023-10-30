// ignore: file_names
import 'package:flutter/material.dart';
import 'package:svt_tabla/tablaObject.dart';

class ShowTabl extends StatelessWidget {
  final String formattedDate;
  final dynamic child;
  final Tablaobject timeTable;
  const ShowTabl(
      {super.key,
      required this.timeTable,
      required this.formattedDate,
      this.child});
  @override
  Widget build(BuildContext context) {
    print('formattedDate in ShowTabl: $formattedDate'); // Add this line

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
            Text(
              "date: $formattedDate",
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

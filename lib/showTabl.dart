import 'package:flutter/material.dart';
import 'package:svt_tabla/tablaObject.dart';

class ShowTabl extends StatelessWidget {
  dynamic child;
  final TablaObject timeTable;
  ShowTabl({required this.timeTable, this.child});
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
              style: TextStyle(color: Colors.amber),
            ),
            Text(
              'Slogan: ${timeTable.slogan} ',
              style: TextStyle(color: Colors.white),
            ),
            Text('Date: ${timeTable.dateFormatter.format('yyyy-MM-dd')}'),
            Text('On Live: ${timeTable.onLive ? 'Yes' : 'No'}'),
            timeTable.image, // Visa bilden här
          ],
        )),
      ),
    );
  }
}

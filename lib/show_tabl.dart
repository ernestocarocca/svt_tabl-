import 'package:flutter/material.dart';
import 'package:svt_tabla/tablaObject.dart';

class ShowTabl extends StatelessWidget {
  final Tablaobject timeTable;

  const ShowTabl({
    Key? key,
    required this.timeTable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          // Bilden som bakgrund
          Image.network(
            timeTable.imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Overlay för text
          Positioned(
            left: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black
                    .withOpacity(0.5), // Justera opaciteten efter behov
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${timeTable.timetableName} ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Tid: ${timeTable.date}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Datum: ${timeTable.time}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

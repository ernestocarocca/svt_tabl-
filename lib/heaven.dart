import 'package:flutter/material.dart';

class Heaven extends StatelessWidget {
  final String child;
  Heaven({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomPaint(
        size: Size(100, 100), // Ange storleken som du vill ha här
        painter: SkyPainter(),
        child: Center(
          child: Text(
            child,
            style: const TextStyle(fontSize: 40, color: Colors.purpleAccent),
          ),
        ),
      ),
    );
  }
}

class SkyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    paintSky(canvas, rect);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

void paintSky(Canvas canvas, Rect rect) {
  const RadialGradient gradient = RadialGradient(
    center: Alignment(0.7, -0.6), // nära övre höger hörn
    radius: 0.2,
    colors: <Color>[
      Color(0xFFFFFF00), // gul sol
      Color(0xFF0099FF), // blå himmel
    ],
    stops: <double>[0.4, 1.0],
  );

  canvas.drawRect(
    rect,
    Paint()..shader = gradient.createShader(rect),
  );
}

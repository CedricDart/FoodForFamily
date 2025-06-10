import 'package:flutter/material.dart';
import 'dart:math' as math;

class SunShape extends ShapeBorder {
  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()..color = Colors.yellow; // Change color as needed

    // Draw the sun circle
    final sunRadius = rect.width / 2 - 10; // Adjust for padding
    canvas.drawCircle(rect.center, sunRadius, paint);

    // Draw sun rays
    final rayLength = 20.0; // Length of the rays
    for (int i = 0; i < 12; i++) {
      final angle = (math.pi / 6) * i; // 30 degrees for 12 rays
      final x1 = rect.center.dx + sunRadius * math.cos(angle);
      final y1 = rect.center.dy + sunRadius * math.sin(angle);
      final x2 = rect.center.dx + (sunRadius + rayLength) * math.cos(angle);
      final y2 = rect.center.dy + (sunRadius + rayLength) * math.sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(20);

  @override
  ShapeBorder scale(double t) => SunShape();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addOval(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addOval(rect);
  }

  @override
  bool get shouldReclip => false;
}

class SunButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sun Shape FAB Example')),
      body: Center(child: Text('Press the sun button')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Your action here
        },
        shape: SunShape(),
        child: const Icon(Icons.wb_sunny_outlined, color: Colors.white), // Sun icon
        backgroundColor: Colors.yellow,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SunButtonExample()));
}

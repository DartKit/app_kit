import 'dart:math';

import 'package:flutter/material.dart';

///
/// desc:
///

// class WaterRipplePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Container(height: 200, width: 200, child: WaterRipple())),
//     );
//   }
// }

class WaterRipple extends StatefulWidget {
  final int count;
  final Color color;
  final double? opacity;

  const WaterRipple(
      {super.key,
      this.count = 3,
      this.color = const Color(0xFF0080ff),
      this.opacity = 1.0});

  @override
  _WaterRippleState createState() => _WaterRippleState();
}

class _WaterRippleState extends State<WaterRipple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WaterRipplePainter(_controller.value,
              count: widget.count,
              color: widget.color,
              opacity: widget.opacity),
        );
      },
    );
  }
}

class WaterRipplePainter extends CustomPainter {
  final double progress;
  final int count;
  final Color color;
  final double? opacity;

  Paint _paint = Paint()..style = PaintingStyle.fill;

  WaterRipplePainter(this.progress,
      {this.count = 3, this.color = const Color(0xFF0080ff), this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width / 2, size.height / 2);

    for (int i = count; i >= 0; i--) {
      double op = (1.0 - ((i + progress) / (count + 1)));
      if (opacity != null) op = opacity!;
      _paint.color = color.withOpacity(op);
      double radius0 = radius * ((i + progress) / (count + 1));

      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), radius0, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

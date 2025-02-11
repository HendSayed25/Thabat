import 'package:flutter/material.dart';

import '../../failed_screen/faild_screen.dart';
import '../../success_screen/success_screen.dart';

class TriangleTracker extends StatefulWidget {

  final bool showHint;
  const TriangleTracker({Key? key, required this.showHint}) : super(key: key);

  @override
  _TriangleTrackerState createState() => _TriangleTrackerState();
}

class _TriangleTrackerState extends State<TriangleTracker> {
  List<Offset> trianglePoints = [];
  List<Offset> userPath = [];
  bool isSuccess = false;
  bool isFailed = false;


  @override
  void initState() {
    super.initState();
    _initializeTriangle();
  }

  void _initializeTriangle() {//draw the triangle
    double scale =1.2;
    trianglePoints = [
      Offset(130*scale, 10*scale),
      Offset(8*scale, 250*scale),
      Offset(260*scale, 250*scale),
    ];
  }

  void _checkPath() {//check if touch 3 vertices of triangle or not
    List<bool> verticesTouched = [false, false, false];
    double threshold = 20.5;

    for (var point in userPath) {
      if (!verticesTouched[0] && (point - trianglePoints[0]).distance < threshold) {
        verticesTouched[0] = true;
      }
      if (!verticesTouched[1] && (point - trianglePoints[1]).distance < threshold) {
        verticesTouched[1] = true;
      }
      if (!verticesTouched[2] && (point - trianglePoints[2]).distance < threshold) {
        verticesTouched[2] = true;
      }
    }

    if (verticesTouched.every((vertex) => vertex)) {
      setState(() {
        isSuccess = true;
        isFailed = false;
      });

      Future.delayed(Duration.zero, () {//go to success screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuccessScreen()),
        );
      });
    } else {
      setState(() {
        isFailed = true;
        isSuccess = false;
      });

      Future.delayed(Duration.zero, () {//go to faild screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FaildScreen()),
        );
      });
    }

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        userPath.clear();
        isSuccess = false;
        isFailed = false;
      });
    });
  }  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(300, 300),
          painter: TrianglePainter(trianglePoints, userPath,widget.showHint),
        ),
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              userPath.add(details.localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) {
            _checkPath();
          },
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final List<Offset> trianglePoints;
  final List<Offset> userPath;
  final bool showHint;

  TrianglePainter(this.trianglePoints, this.userPath,this.showHint);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final path = Path();
    path.moveTo(trianglePoints[0].dx, trianglePoints[0].dy);
    path.lineTo(trianglePoints[1].dx, trianglePoints[1].dy);
    path.lineTo(trianglePoints[2].dx, trianglePoints[2].dy);
    path.close();

    final dashWidth = 13.0;
    final dashSpace = 5.0;
    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      var start = 0.0;
      while (start < pathMetric.length) {
        final end = start + dashWidth;
        canvas.drawPath(
          pathMetric.extractPath(start, end),
          paint,
        );
        start += dashWidth + dashSpace;
      }
    }

    final userPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final userPathDraw = Path();
    if (userPath.isNotEmpty) {
      userPathDraw.moveTo(userPath[0].dx, userPath[0].dy);
      for (var point in userPath) {
        userPathDraw.lineTo(point.dx, point.dy);
      }
    }

    canvas.drawPath(userPathDraw, userPaint);

    if (showHint) {
      final hintPaint = Paint()
        ..color = Colors.green.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round;

      final hintPath = Path();
      hintPath.moveTo(trianglePoints[0].dx, trianglePoints[0].dy);
      hintPath.lineTo(trianglePoints[1].dx, trianglePoints[1].dy);
      hintPath.lineTo(trianglePoints[2].dx, trianglePoints[2].dy);
      hintPath.close();

      canvas.drawPath(hintPath, hintPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
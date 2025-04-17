import 'package:flutter/material.dart';

class FrameBorderPainter extends CustomPainter {
  FrameBorderPainter({this.topLeft = true, this.topRight = false, this.bottomLeft = false, this.bottomRight = true, this.strokeWidth = 1, this.dx = 10, this.cornerRadius = 1});
  bool topLeft;
  bool topRight;
  bool bottomLeft;
  bool bottomRight;
  double strokeWidth;
  double dx;
  double cornerRadius;

  @override
  void paint(Canvas canvas, Size size) {
    var lineColor = Colors.grey.shade500;
    Paint paint =
        Paint()
          ..color = lineColor
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = strokeWidth;

    if (topLeft) {
      topLeftPaint(canvas, size, dx, lineColor, strokeWidth, cornerRadius, paint);
    }
    if (topRight) {
      topRightPaint(canvas, size, dx, lineColor, strokeWidth, cornerRadius, paint);
    }
    if (bottomLeft) {
      bottomLeftPaint(canvas, size, dx, lineColor, strokeWidth, cornerRadius, paint);
    }
    if (bottomRight) {
      bottomRightPaint(canvas, size, dx, lineColor, strokeWidth, cornerRadius, paint);
    }
  }

  void topLeftPaint(Canvas canvas, Size size, double dx, Color lineColor, double strokeWidth, double cornerRadius, Paint paint) {
    Path path = Path();
    path.moveTo(0, dx);

    // Köşe yuvarlama
    path.lineTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // Köşeden geçmeyecek şekilde üst çizgi
    path.moveTo(cornerRadius, 0);
    path.lineTo(dx, 0);

    canvas.drawPath(path, paint);
  }

  void topRightPaint(Canvas canvas, Size size, double dx, Color lineColor, double strokeWidth, double cornerRadius, Paint paint) {
    Path path = Path();
    path.moveTo(size.width - dx, 0);

    // Köşe yuvarlama
    path.lineTo(size.width - cornerRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // Köşeden geçmeyecek şekilde üst çizgi
    path.moveTo(size.width, cornerRadius);
    path.lineTo(size.width, dx);

    canvas.drawPath(path, paint);
  }

  void bottomLeftPaint(Canvas canvas, Size size, double dx, Color lineColor, double strokeWidth, double cornerRadius, Paint paint) {
    Path path = Path();
    path.moveTo(0, size.height - dx);

    // Köşe yuvarlama
    path.lineTo(0, size.height - cornerRadius);
    path.quadraticBezierTo(0, size.height, cornerRadius, size.height);

    // Köşeden geçmeyecek şekilde sol çizgi
    path.moveTo(cornerRadius, size.height);
    path.lineTo(dx, size.height);

    canvas.drawPath(path, paint);
  }

  void bottomRightPaint(Canvas canvas, Size size, double dx, Color lineColor, double strokeWidth, double cornerRadius, Paint paint) {
    Path path = Path();
    path.moveTo(size.width - dx, size.height);

    // Köşe yuvarlama
    path.lineTo(size.width - cornerRadius, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - cornerRadius);

    // Köşeden geçmeyecek şekilde sağ çizgi
    path.moveTo(size.width, size.height - cornerRadius);
    path.lineTo(size.width, size.height - dx);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

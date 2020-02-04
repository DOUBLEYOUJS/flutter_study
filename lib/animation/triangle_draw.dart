import 'package:flutter/cupertino.dart';

///绘制三角形类
class TrianglePainter extends CustomPainter {
  Color _color;
  Trangle _trangle;
  Paint _paint = new Paint();

  TrianglePainter(this._trangle, this._color);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    _paint.color = _color;
    Path path = new Path()..moveTo(_trangle.p1.x, _trangle.p1.y);
    path.lineTo(_trangle.p2.x, _trangle.p2.y);
    path.lineTo(_trangle.p3.x, _trangle.p3.y);

    canvas.drawPath(path, _paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }


}

class Trangle {
  Point p1;
  Point p2;
  Point p3;

  Trangle(this.p1, this.p2, this.p3);
}

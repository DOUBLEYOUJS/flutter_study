import 'dart:math' as prefix0;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_study/animation/triangle_draw.dart';
import 'package:flutter_study/utils/log_util.dart';

///
/// 米UI动画三角形绘制
class MiUiTriangleDraw extends CustomPainter {
  List<TriangleViewEntity> triangleList;

  Paint _paint = Paint();

  Path _path = Path();

  MiUiTriangleDraw(this.triangleList);

  @override
  void paint(Canvas canvas, Size size) {
    int size = triangleList.length;
    TriangleViewEntity entity;
    for (int i = 0; i < size; i++) {
      entity = triangleList[i];
      //LogUtils.e("绘制：$i ${entity.toString()}");
      _path.reset();
      _path
        ..moveTo(entity.startP.x, entity.startP.y)
        ..lineTo(entity.currentP1.x, entity.currentP1.y)
        ..lineTo(entity.currentP2.x, entity.currentP2.y);
      _path.close();
      _paint
        ..color = entity.color
        ..style = PaintingStyle.fill;
      canvas.drawPath(_path, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SingleTriangleViewDraw extends CustomPainter {
  TriangleViewEntity _entity;
  Paint _paint;
  Path _path;

  SingleTriangleViewDraw(this._entity) {
    _paint = Paint()
      ..color = _entity.color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    _path = Path()
      ..lineTo(_entity.startP.x, _entity.startP.y)
      ..moveTo(_entity.currentP1.x, _entity.currentP1.y)
      ..moveTo(_entity.currentP2.x, _entity.currentP2.y);

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

///
/// 绘制三角形实例
class TriangleViewEntity {
  Point startP;
  Point endP1;
  Point endP2;

  Point currentP1;
  Point currentP2;

  Color color;

  TriangleViewEntity(this.startP, this.endP1, this.endP2, this.color,
      {this.currentP1, this.currentP2}) {
    if (currentP1 == null) {
      currentP1 = startP;
    }

    if (currentP2 == null) {
      currentP2 = startP;
    }
  }

  @override
  String toString() {
    return 'TriangleViewEntity{startP: $startP, endP1: $endP1, endP2: $endP2, currentP1: $currentP1, currentP2: $currentP2, color: $color}';
  }
}

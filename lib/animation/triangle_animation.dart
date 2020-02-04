import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study/animation/triangle_draw.dart';
import 'package:flutter_study/utils/log_util.dart';

///三角形动画类
class TriangleAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TriangleAnimationState();
  }
}

class TriangleAnimationState extends State<TriangleAnimation>
    with SingleTickerProviderStateMixin {
  Point _point1;

  static const double LENGTH = 200;

  double _trangleHeight;
  double _length;
  bool isReverse = false;

  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _length = LENGTH;
    _trangleHeight = math.sqrt(3) / 2 * _length;

    // 创建一个动画控制器
    this.controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    final CurvedAnimation curve =
    CurvedAnimation(parent: controller, curve: Curves.linear);

    // 变化的值
    animation = Tween(begin: 1.0, end: 0.0).animate(curve);
    animation.addListener(() {
      setState(() {
          _length = LENGTH * animation.value;
          _trangleHeight = math.sqrt(3) / 2 * _length;
      });
    });
    animation.addStatusListener((status){
      switch(status){
        case AnimationStatus.completed:
          LogUtils.e("AnimationStatus.completed...结束");
          controller.forward(from: 0.0);
          break;
        case AnimationStatus.dismissed:
          LogUtils.e("AnimationStatus.dismissed...");
          controller.forward(from: 0.0);
          break;
        case AnimationStatus.forward:
          LogUtils.e("AnimationStatus.forward...开始");
          break;
        case AnimationStatus.reverse:
          LogUtils.e("AnimationStatus.reverse...反向");
          break;
      }
    });
    controller.forward();
  }

  _buildTrangle(Point p1) {
    Point p2 = Point(p1.x + _trangleHeight, p1.y - _length / 2);

    Point p3 = Point(p1.x + _trangleHeight, p1.y + _length / 2);

    return Trangle(p1, p2, p3);
  }

  @override
  Widget build(BuildContext context) {
    //ScreenUtil.instance = ScreenUtil()
    //  ..init(context);
    _point1 = Point(
        (ScreenUtil.screenWidthDp - LENGTH) / 2,
        ScreenUtil.screenHeightDp / 2);
    return Scaffold(
      appBar: AppBar(
        title: Text("三角形绘制"),
      ),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: CustomPaint(
            size: Size(ScreenUtil.screenWidthDp, ScreenUtil.screenHeightDp),
            painter: TrianglePainter(_buildTrangle(_point1), Colors.green),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();

  }
}

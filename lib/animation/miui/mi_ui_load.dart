import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study/animation/miui/triangle_view.dart';
import 'package:flutter_study/animation/triangle_draw.dart';
import 'package:flutter_study/utils/log_util.dart';

///
/// 小米加载动画
class MiUiLoad extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MIUiLoadState();
  }
}

enum LoadStatus {
  MID_LOADING,
  FIRST_LOADING,
  SECOND_LOADING,
  THIRD_LOADING,
  THIRD_DISMISS,
  FIRST_DISMISS,
  SECOND_DISMISS,
  MID_DISMISS
}

class MIUiLoadState extends State<MiUiLoad>
    with SingleTickerProviderStateMixin {
  static const LENGTH = 200;

  List<TriangleViewEntity> _list;
  Animation _animation;
  AnimationController _controller;

  LoadStatus _status = LoadStatus.MID_LOADING;
  double _height;
  bool _isFirst = true;

  _createTriangle() {
    ///
    /// 小米动画包含4个小三角形，一共六个固定点
    /// p1，p2,p3为最外面的3个点
    ///
    Point p1 = Point((ScreenUtil.screenWidthDp + _height) / 2,
        ScreenUtil.screenHeightDp / 2 - 50);

    Point p2 = Point(p1.x - _height, p1.y - LENGTH / 2);
    Point p3 = Point(p1.x - _height, p1.y + LENGTH / 2);

    ///cp12,cp23,cp13为边线中点

    Point p12 = Point(p1.x - _height / 2, p1.y - LENGTH / 4);
    Point p13 = Point(p1.x - _height / 2, p1.y + LENGTH / 4);
    Point p23 = Point(p1.x - _height, p1.y);

    ///4个三角形数据
    ///出现顺序是 中，1,2,3
    ///消失顺序是 3,1,2，中
    ///中心三角形
    TriangleViewEntity center =
        TriangleViewEntity(p13, p12, p23, Colors.deepPurple);

    ///上面
    TriangleViewEntity t1 = TriangleViewEntity(p23, p12, p2, Colors.yellow);

    ///右边
    TriangleViewEntity t2 = TriangleViewEntity(p12, p13, p1, Colors.cyan);

    ///左边
    TriangleViewEntity t3 = TriangleViewEntity(p13, p23, p3, Color(0xffff0000));
    return [center, t1, t2, t3];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _height = math.sqrt(3) / 2 * LENGTH;

    _controller = AnimationController(
        duration: Duration(milliseconds: 500), vsync: this);
    //线形变化
    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.linear);

    _animation = Tween(begin: 0.0, end: 1.0).animate(curvedAnimation);

    _animation.addListener(() {
      if (_list != null) {
        setState(() {
          _loadAnimation(_animation.value);
        });
      }
    });

    _animation.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          LogUtils.e("开始......");
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.dismissed:
          break;
        case AnimationStatus.completed:
          changeStatus();
          int index = LoadStatus.values.indexOf(_status);
          _updateListData(index);
          ///这里必须要加入from，否则无法循环执行
          _controller.forward(from: 0.0);
          break;
      }
    });

    _controller.forward();
  }

  _loadAnimation(value) {
    ///注意对应顺序
    int index = LoadStatus.values.indexOf(_status);
    TriangleViewEntity entity;
    switch (_status) {
      case LoadStatus.MID_LOADING:
      case LoadStatus.FIRST_LOADING:
      case LoadStatus.SECOND_LOADING:
      case LoadStatus.THIRD_LOADING:
        entity = _list[index];
        //loading
        _updatePointData(entity, value, true);
        break;
      case LoadStatus.THIRD_DISMISS:
        entity = _list[3];
        _updatePointData(entity, value, false);
        break;
      case LoadStatus.FIRST_DISMISS:
        entity = _list[1];
        _updatePointData(entity, value, false);
        break;
      case LoadStatus.SECOND_DISMISS:
        entity = _list[2];
        _updatePointData(entity, value, false);
        break;
      case LoadStatus.MID_DISMISS:
        entity = _list[0];
        _updatePointData(entity, value, false);
        break;
    }
  }

  _updatePointData(entity, value, isLoading) {
    if (isLoading) {
      _createPoint(entity, value);
    } else {
      _createPoint(entity, 1 - value);
    }
  }

  ///消失和开始顺序和起始点数据需要变换
  ///start点和p1需要交换位置
  _updateListData(index) {
    if ((index == 0 && !_isFirst) || index == 4) {
      _isFirst = false;
      TriangleViewEntity entity;
      for (int i = 0; i < _list.length; i++) {
        entity = _list[i];
        Point temp = entity.startP;
        entity.startP = entity.endP1;
        entity.endP1 = temp;

        if (index == 4) {
          entity.currentP1 = entity.endP1;
          entity.currentP2 = entity.endP2;
        } else {
          entity.currentP1 = entity.startP;
          entity.currentP2 = entity.startP;
        }
      }
    }
  }

  _createPoint(TriangleViewEntity entity, value) {
    double currentX1 =
        entity.startP.x + value * (entity.endP1.x - entity.startP.x);
    double currentX2 =
        entity.startP.x + value * (entity.endP2.x - entity.startP.x);
    double currentY1 =
        entity.startP.y + value * (entity.endP1.y - entity.startP.y);
    double currentY2 =
        entity.startP.y + value * (entity.endP2.y - entity.startP.y);

    entity.currentP1 = Point(currentX1, currentY1);
    entity.currentP2 = Point(currentX2, currentY2);
  }

  changeStatus() {
    int index = LoadStatus.values.indexOf(_status) + 1;
    if (index >= LoadStatus.values.length) {
      _status = LoadStatus.values[0];
    } else {
      _status = LoadStatus.values[index];
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //ScreenUtil.instance = ScreenUtil()..init(context);

    if (_list == null) {
      _list = _createTriangle();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("小米加载动画"),
        ),
        body: Center(
          child: CustomPaint(
            size:
                Size(ScreenUtil.screenWidthDp, ScreenUtil.screenHeightDp - 100),
            painter: MiUiTriangleDraw(_list),
          ),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}

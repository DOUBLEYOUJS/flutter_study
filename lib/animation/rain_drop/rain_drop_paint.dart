import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/utils/log_util.dart';

class RainDropWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RainDropState();
  }
}

class RainDropState extends State<RainDropWidget>
    with SingleTickerProviderStateMixin {
  List<Rain> _list;
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list = List();

    LogUtils.e("雨点数据：${_list.length}");
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            if (_list.isNotEmpty) {
              setState(() {});
            } else {
              _controller.stop();
            }
          });
    //_controller.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("雨滴图"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            if (!_controller.isAnimating) {
              _list.add(Rain(150, 160,maxRadius: 80));
              _list.add(Rain(155, 154,maxRadius: 20));
              _list.add(Rain(167, 180,maxRadius: 100));
              _list.add(Rain(150, 160));
              _list.add(Rain(80, 260,maxRadius: 50));
              _list.add(Rain(130, 190,maxRadius: 53));
              _controller.repeat();
            }
          },
          child: Container(
            color: Colors.cyan,
            child: CustomPaint(
              size: Size(320, 500),
              painter: RainDropPainter(_list),
            ),
          ),
        )
      ),
    );
  }
}

class RainDropPainter extends CustomPainter {
  List<Rain> list;

  Paint _paint = Paint()..style = PaintingStyle.stroke;

  RainDropPainter(this.list);

  @override
  void paint(Canvas canvas, Size size) {
    LogUtils.e("draw.......${list.length}");
    list.forEach((e) {
      e.drawRainDrop(canvas, _paint);
    });

    list.removeWhere((e){
      return !e.isValid();
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Rain {
  //雨点大小各不相同
  double maxRadius;
  double x;
  double y;
  double radius = 5;

  Rain(this.x, this.y,{this.maxRadius = 30});

  drawRainDrop(Canvas canvas, Paint paint) {
    double opt = (maxRadius - radius) / maxRadius;
    paint.color = Color.fromRGBO(0, 0, 0, opt);
    canvas.drawCircle(Offset(x, y), radius, paint);
    radius += 0.5;
  }

  bool isValid() {
    return radius < maxRadius;
  }
}

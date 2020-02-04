import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/image/data.dart' as module;

///仿网易云banner样式
class BannerItemView extends StatelessWidget {
  module.BannerItem data;
  double radius = 12;
  double height = 140;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image:
              DecorationImage(image: NetworkImage(data.pic), fit: BoxFit.fill)),
      child: Container(
        child: Text(
          data.typeTitle,
          style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.normal,

              ///默认有下划线,使用TextDecoration去掉
              decoration: TextDecoration.none),
        ),
        padding: EdgeInsets.only(left: 6, right: 6, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius)),
            color: Colors.red),
      ),
      alignment: AlignmentDirectional.bottomEnd,
    );
  }

  BannerItemView(this.data, {this.height, this.radius});
}

class CircleItem extends StatelessWidget {
  Color color;
  double size;

  CircleItem(this.color, this.size);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(size)),
    );
  }
}

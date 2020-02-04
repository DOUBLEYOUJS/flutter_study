import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/image/data.dart';

import 'banner.dart';

///image 网络图片：http:\/\/p1.music.126.net\/tDl2Ly0qsZAXSR9FkQNGzQ==\/109951164540559950.jpg
///

class ImageWidget extends StatelessWidget {
  BannerItem item = BannerItem(
      pic:
          "http:\/\/p1.music.126.net\/tDl2Ly0qsZAXSR9FkQNGzQ==\/109951164540559950.jpg",
      typeTitle: "独家自制");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Image(
          image: AssetImage("images/image_1.jpg"),
        ),
        Container(
          height: 20,
        ),
        Image(
          image: NetworkImage(
              "http://p1.music.126.net/tDl2Ly0qsZAXSR9FkQNGzQ==/109951164540559950.jpg"),
        ),
        Container(
          height: 20,
        ),
        FadeInImage(
          placeholder: AssetImage("images/image_2.jpg"),
          image: NetworkImage(
              "http://p1.music.126.net/tDl2Ly0qsZAXSR9FkQNGzQ==/109951164540559950.jpg"),
        ),
        Container(
          height: 20,
        ),

        ///截图的方式ClipRRect
        ///Image scale 原图缩放比例
        ///fit 填充方式

        ClipRRect(
            child: Image.network(
                "http://p1.music.126.net/tDl2Ly0qsZAXSR9FkQNGzQ==/109951164540559950.jpg",
                scale: 1, //原图缩放比例
                fit: BoxFit.fill),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        Container(
          height: 20,
        ),

        ///decoration 设置边框、背景色、背景图片、圆角等属性
        ///它不会支撑控件的显示，所有没有高度宽度等信息无法显示
        Container(
          height: 120,
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(
                      "http://p1.music.126.net/tDl2Ly0qsZAXSR9FkQNGzQ==/109951164540559950.jpg"),
                  fit: BoxFit.fill)),
        ),
        Container(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: BannerItemView(item, height: 140, radius: 5),
        ),

        Container(
          height: 20,
        ),
      ],
    );
  }
}

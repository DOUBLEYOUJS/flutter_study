import 'dart:ui' as prefix0;

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study/sliver/custom_flexible_space_bar.dart';
import 'package:flutter_study/sliver/flexible_more_bar.dart';

///网易云每日推荐AppBar样式
///
class NetEaseAppBarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //SliverAppBar变化，导致flexibleSpace变化
          SliverAppBar(
            flexibleSpace: FlexibleMoreBar(
              background: Image.asset("images/ic_test.jpg",
                  width: double.infinity, //这里必须加高宽 double.infinity，
                  height: double.infinity, //否则无法覆盖完
                  fit: BoxFit.cover),
              content: Column(
                children: <Widget>[
                  Spacer(), //填充
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                    margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                '${DateUtil.formatDate(DateTime.now(), format: 'dd')} ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                        TextSpan(
                            text:
                                '/ ${DateUtil.formatDate(DateTime.now(), format: 'MM')} ',
                            style: TextStyle(color: Colors.white, fontSize: 16))
                      ]),
                    ),
                  ),
                ],
              ),
              isCollapsedChangeBg: true,
              title: Text("每日推荐",style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
            bottom: PreferredSize(
              child: Container(
                  height: ScreenUtil().setHeight(100),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "我的选项",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Colors.white)),
              preferredSize:
                  Size(ScreenUtil.screenWidth, ScreenUtil().setHeight(100)),
            ),
            automaticallyImplyLeading: true,
            expandedHeight: ScreenUtil().setHeight(480),
            //appbar显示
            pinned: true,
            floating: false,
            snap: false,
            forceElevated: false,
            //ture 状态栏下方，false不要状态栏
            primary: true,
            //固定title
            //title: Text("每日推荐"),
          ),
          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                title: Text("Item $index"),
              );
            }, childCount: 30),
          )
        ],
      ),
    );
  }
}

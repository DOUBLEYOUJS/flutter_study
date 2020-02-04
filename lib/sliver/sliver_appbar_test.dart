import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study/sliver/custom_flexible_space_bar.dart';

class SliverAppBarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //SliverAppBar变化，导致flexibleSpace变化
          SliverAppBar(
            ///一般默认情况
//            flexibleSpace: FlexibleSpaceBar(
//              background: Image.asset("images/bg_header.jpg",fit: BoxFit.fill),
//              centerTitle: false,
//              collapseMode: CollapseMode.none,
//            ),
          ///背景不改变
//            flexibleSpace: CustomFlexibleSpaceBar(
//              background: Image.asset("images/bg_header.jpg",fit: BoxFit.fill),
//            ),
          ///加入模糊层
            flexibleSpace: CustomFlexibleSpaceBar(
              background:Stack(
                children: <Widget>[
                  Image.asset("images/bg_header.jpg",
                      width: double.infinity,//这里必须加高宽 double.infinity，
                      height: double.infinity,//否则无法覆盖完
                      fit: BoxFit.cover),
                  BackdropFilter(
                    filter: prefix0.ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      color: Colors.black38,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                ],
              ),
            ),
            bottom:PreferredSize(
              child: Container(
                child: Text("我的选项",style: TextStyle(color: Colors.black,fontSize: 16),),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Colors.white)
              ),
              preferredSize: Size(ScreenUtil.screenWidth, ScreenUtil().setHeight(50)),
            ) ,
            automaticallyImplyLeading: true,
            expandedHeight: 180,
            //appbar显示
            pinned: true,
            floating: false,
            snap: false,
            forceElevated: false,
            //ture 状态栏下方，false不要状态栏
            primary: true,
            //固定title
            title: Text("标题标题"),
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

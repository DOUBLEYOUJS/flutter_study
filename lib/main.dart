import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study/animation/rain_drop/rain_drop_paint.dart';
import 'package:flutter_study/application.dart';
import 'package:flutter_study/image/image_widget.dart';
import 'package:flutter_study/network/network_test.dart';
import 'package:flutter_study/provider/provider_test.dart';
import 'package:flutter_study/router/page_first.dart';
import 'package:flutter_study/router/routes.dart';
import 'package:flutter_study/sliver/sliver_appbar_test.dart';

import 'package:flutter_study/tabbar/tab_pageview_test.dart';
import 'package:flutter_study/tabbar/tab_pageview_test2.dart';
import 'package:flutter_study/tabbar/tab_test.dart';

import 'animation/miui/mi_ui_load.dart';
import 'animation/triangle_animation.dart';

///android studio创建时默认创建的一个main.dart
///

//flutter运行起点
void main() {
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  
  
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

//不可变widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyHomePage(),
      onGenerateRoute: Application.router.generator,

    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter 学习"),
      ),
      body: Column(
        children: <Widget>[
          MaterialButton(
            child: Text("Tab学习",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              Application.router.navigateTo(context, Routes.tabTest);
            },
          ),
          MaterialButton(
            child: Text("PageView+Tab学习",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              Application.router.navigateTo(context, Routes.tabPageViewTest);
            },
          ),
          MaterialButton(
            child: Text("三角形动画",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              Application.router.navigateTo(context, Routes.triangleAnimation);
            },
          ),
          MaterialButton(
            child: Text("小米动画",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              Application.router.navigateTo(context, Routes.miUiLoad);
            },
          ),
          MaterialButton(
            child: Text("雨滴动画",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              Application.router.navigateTo(context, Routes.rainDropWidget);
            },
          ),
          MaterialButton(
            child: Text("路由跳转学习",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              Application.router.navigateTo(context, Routes.firstPage);
            },
          ),
          MaterialButton(
            child: Text("网络加载学习",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              Application.router.navigateTo(context, Routes.networkTest);
            },
          ),
          MaterialButton(
            child: Text("InheritedWidget学习",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              Application.router.navigateTo(context, Routes.inheritedWidgetTest);
            },
          ),
          MaterialButton(
            child: Text("Sliver学习",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              Application.router.navigateTo(context, Routes.sliverAppBarTest);
            },
          ),
          MaterialButton(
            child: Text("网易云每日推荐",style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              Application.router.navigateTo(context, Routes.netEaseAppBarTest);
            },
          ),
        ],
      ),
    );
  }

}

////状态可变的widget,
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
////状态改变，会导致控件的而重新绘制，
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    print("_incrementCounter");
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    //Material Design 可视化布局结构
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      //Center居中
//      body: Center(
//        //垂直布局
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}

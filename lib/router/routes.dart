import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_study/animation/miui/mi_ui_load.dart';
import 'package:flutter_study/animation/rain_drop/rain_drop_paint.dart';
import 'package:flutter_study/animation/triangle_animation.dart';
import 'package:flutter_study/network/network_test.dart';
import 'package:flutter_study/router/page_first.dart';
import 'package:flutter_study/router/page_second.dart';
import 'package:flutter_study/sliver/netease_appbar_test.dart';
import 'package:flutter_study/sliver/sliver_appbar_test.dart';
import 'package:flutter_study/tabbar/tab_pageview_test.dart';
import 'package:flutter_study/tabbar/tab_test.dart';
import 'package:flutter_study/widget/inherited_widget_test.dart';

class Routes {
  ///
  ///      home: TabTest(),
  ///      home: TabPageViewTest(),
  ///      home: TriangleAnimation(),
  ///     home: MiUiLoad(),
  ///      home: RainDropWidget(),
  ///      home: NetworkTest(),
  ///     home: FirstPage(),
  ///     onGenerateRoute: Application.router.generator,
  ///     home: SliverAppBarTest(),
  static final String firstPage = "/firstPage";
  static final String secondPage = "/secondPage";
  static final String tabTest = "/tabTest";
  static final String tabPageViewTest = "/tabpageviewtest";
  static final String triangleAnimation = "/triangleAnimation";
  static final String miUiLoad = "/miUiLoad";
  static final String rainDropWidget = "/rainDropWidget";
  static final String networkTest = "/networkTest";
  static final String sliverAppBarTest = "/sliverAppBarTest";
  static final String inheritedWidgetTest = "/inheritedWidgetTest";
  static final String netEaseAppBarTest = "/netEaseAppBarTest";



  static Map<String, WidgetBuilder> routes;

//  static initRoute() {
//    routes = {
//      firstPage: (context) => FirstPage(),
//      secondPage: (context) => SecondPage()
//    };
//    return routes;
//  }

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return FirstPage();
        });
    router.define(firstPage, handler: firstHandler);
    router.define(secondPage, handler: secondHandler);
    router.define(tabTest, handler: tabTestHandler);
    router.define(tabPageViewTest, handler: tabPageViewTestHandler);
    router.define(triangleAnimation, handler: triangleAnimationHandler);
    router.define(miUiLoad, handler: miUiLoadHandler);
    router.define(rainDropWidget, handler: rainDropWidgetHandler);
    router.define(networkTest, handler: networkTestHandler);
    router.define(sliverAppBarTest, handler: sliverAppBarTestHandler);
    router.define(inheritedWidgetTest, handler: inheritedWidgetTestHandler);
    router.define(netEaseAppBarTest, handler: netEaseAppBarTestHandler);
  }
}

var firstHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return FirstPage();
    });

var secondHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return SecondPage();
    });

var tabTestHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return TabTest();
    });

var tabPageViewTestHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return TabPageViewTest();
    });

var triangleAnimationHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return TriangleAnimation();
    });

var miUiLoadHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return MiUiLoad();
    });

var rainDropWidgetHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return RainDropWidget();
    });

var networkTestHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return NetworkTest();
    });
var sliverAppBarTestHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return SliverAppBarTest();
    });
var inheritedWidgetTestHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return InheritedWidgetTest();
    });
var netEaseAppBarTestHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return NetEaseAppBarTest();
    });

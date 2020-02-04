import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/utils/log_util.dart';

class FlexibleMoreBar extends StatelessWidget {
  final Widget background; //展开背景
  final Widget content; //内容
  final Widget title; //标题
  final bool isCollapsedChangeBg; //是否Collapsed背景模糊

  FlexibleMoreBar(
      {Key key,
      @required this.background,
      @required this.content,
      this.title,
      this.isCollapsedChangeBg = false})
      : assert(background != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //获取SliverAppBar的设置
    final FlexibleSpaceBarSettings settings =
        context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);

    final List<Widget> children = <Widget>[];

    final double deltaExtent = settings.maxExtent - settings.minExtent;

    // 0.0 -> Expanded
    // 1.0 -> Collapsed to toolbar
    final double t =
        (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0);

    LogUtils.e("deltaExtent:$deltaExtent status:$t");
    Widget bg;
    if (isCollapsedChangeBg) {
      bg = Stack(
        children: <Widget>[
          background,
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5 * t,
              sigmaY: 5 * t,
            ),
            child: Container(
              color: Colors.black38,
              width: double.infinity,
              height: double.infinity,
            ),
          )
        ],
      );
    } else {
      bg = background;
    }

    children.add(Positioned(
      top: -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t),
      left: 0,
      right: 0,
      height: settings.maxExtent,
      child: bg,
    ));

    double bottomPadding = 0;
    SliverAppBar sliverBar = context.ancestorWidgetOfExactType(SliverAppBar);
    LogUtils.e(
        "bottomPadding:获取sliver isNull: ${sliverBar == null} ${sliverBar.bottom != null}");
    if (sliverBar != null && sliverBar.bottom != null) {
      LogUtils.e("bottomPadding:获取sliver");
      bottomPadding = sliverBar.bottom.preferredSize.height;
    }

    LogUtils.e("bottomPadding:$bottomPadding ${settings.currentExtent}");
    children.add(Positioned(
      top: settings.currentExtent - settings.maxExtent,
      left: 0,
      right: 0,
      height: settings.maxExtent,
      child: Opacity(
        opacity: 1 - t,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: Material(
              child: DefaultTextStyle(
                  style: Theme.of(context).primaryTextTheme.body1,
                  child: Center(
                    child: content,
                  )),
              elevation: 0,
              color: Colors.transparent),
        ),
      ),
    ));

    if (title != null) {
      children.add(Positioned(
        top: 40,
        left: 0,
        right: 0,
        height: 100,
        child: Opacity(
          opacity: t,
          child: Padding(
            padding: EdgeInsets.only(left: 80),
            child: Material(
                child: title,
                elevation: 0,
                color: Colors.transparent),
          ),
        ),
      ));
    }

    return ClipRect(
        child: DefaultTextStyle(
            style: Theme.of(context).primaryTextTheme.body1,
            child: Stack(children: children, fit: StackFit.expand)));
  }
}

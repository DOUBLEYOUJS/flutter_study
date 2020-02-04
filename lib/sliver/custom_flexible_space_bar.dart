import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/utils/log_util.dart';

class CustomFlexibleSpaceBar extends StatelessWidget {
  final Widget background;

  CustomFlexibleSpaceBar({Key key, @required this.background})
      : assert(background != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //
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

    children.add(Positioned(
      top: -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t),
      left: 0,
      right: 0,
      height: settings.maxExtent,
      child: background,
    ));

    double bottomPadding = 0;
    SliverAppBar sliverBar = context.ancestorWidgetOfExactType(SliverAppBar);
    LogUtils.e("bottomPadding:获取sliver isNull: ${sliverBar == null} ${sliverBar.bottom != null}");
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
                    child: Text("我的测试数据"),
                  )),
              elevation: 0,
              color: Colors.transparent),
        ),
      ),
    ));

//    return _FlexibleDetail(select: t,
//        child: ClipRect(
//            child: DefaultTextStyle(
//                style: Theme.of(context).primaryTextTheme.body1,
//                child: Stack(children: children, fit: StackFit.expand))));
    return ClipRect(
        child: DefaultTextStyle(
            style: Theme.of(context).primaryTextTheme.body1,
            child: Stack(children: children, fit: StackFit.expand)));
  }
}

class _FlexibleDetail extends InheritedWidget {
  double select;

  _FlexibleDetail({@required this.select, @required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(_FlexibleDetail oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.select != select;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/utils/log_util.dart';

class InheritedWidgetTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InheritedWidgetTestState();
  }
}

class _InheritedWidgetTestState extends State<InheritedWidgetTest> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("InheritedWidgetTest"),
      ),
      body: Center(
        child: CounterWidget(
          _counter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _TextTest(),
              _TextTest2(),//比较这3个控件，其实就是改变了传递数据的路径。
              TextTest2(_counter),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  "click add count",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

///
/// 这个感觉其实就是通过context.inheritFromWidgetOfExactType来共享数据
///
class CounterWidget extends InheritedWidget {
  int counter;

  CounterWidget(this.counter, {Widget child}) : super(child: child);

  //子类获取
  static CounterWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(CounterWidget);
  }

  @override
  bool updateShouldNotify(CounterWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.counter != counter;
  }
}

//不可变
class _TextTest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    LogUtils.e("build......");
    return Text("不可变控件1:${CounterWidget.of(context).counter.toString()}");
  }
}

//直接传递
class TextTest2 extends StatelessWidget {
  int count;

  TextTest2(this.count);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    LogUtils.e("build......");
    return Text("不可变控件2:$count");
  }
}

class _TextTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TextTestState();
  }
}

class _TextTestState extends State<_TextTest> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("可变控件:${CounterWidget.of(context).counter.toString()}");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    LogUtils.e("didChangeDependencies......");
  }
}

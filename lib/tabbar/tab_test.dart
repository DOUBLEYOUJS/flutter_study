import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study/utils/log_util.dart';

///由于TabController的原因,所以无法使用StatelessWidget
///tabbar加tabBarview的实现
class TabTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabState();
}

class TabState extends State<TabTest> with SingleTickerProviderStateMixin {
  TabController controller;
  int _selectIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(vsync: this, length: 3);
    ///添加监听，这个监听是有延时的，所以效果不好
    controller.addListener(_changePage);
  }

  _changePage(){
    ///有延时
    LogUtils.e("_changePage...${controller.index}");
    setState(() {
      _selectIndex = controller.index;
    });
  }

  TextStyle _defaultStyle = TextStyle(fontSize: 14);
  TextStyle _selectStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  // TabTest() :

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    LogUtils.e("didChangeDependencies...");
  }

  @override
  void didUpdateWidget(TabTest oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    LogUtils.e("didUpdateWidget...");
  }

  @override
  Widget build(BuildContext context) {
    LogUtils.e("build...");
    //ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      //PreferredSize设置高度
      appBar: PreferredSize(
        child: AppBar(
          //AppBar下面阴影
          elevation: 0,
        ),
        preferredSize: Size.zero,
      ),
      backgroundColor: Colors.white,
      //SafeArea 对于异形界面手机显示时处理越界啥的
      body: SafeArea(
        //底部异常
        bottom: false,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(150)),
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    _selectIndex = index;
                  });
                },
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                //labelStyle的设置导致滑动时字体闪烁
//                labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
//                unselectedLabelStyle: TextStyle(fontSize: 14),
                indicator: UnderlineTabIndicator(),
                controller: controller,
                tabs: [
                  Tab(
                    child: Text("我的",
                        style: _selectIndex == 0
                            ? _selectStyle
                            : _defaultStyle),
                  ),
                  Tab(
                    child: Text("发现",
                        style: _selectIndex == 1
                            ? _selectStyle
                            : _defaultStyle),
                  ),
                  Tab(
                    child: Text("云村",
                        style: _selectIndex == 2
                            ? _selectStyle
                            : _defaultStyle),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: <Widget>[
                  Center(
                    child: Text("我的"),
                  ),
                  Center(
                    child: Text("发现"),
                  ),
                  Center(
                    child: Text("云村"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}

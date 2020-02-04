import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study/utils/log_util.dart';

///AppBar中添加tabbar+PageView的实现
class TabPageViewTest2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabTestState();
}

class TabTestState extends State<TabPageViewTest2>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;

  int _selectIndex = 0;
  bool _isOnTab = false;

  TextStyle _defaultStyle = TextStyle(fontSize: 16);
  TextStyle _selectStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: 0);
  }

  _onTabPageChange(index, {bool isOnTab = false}) {
    if (_selectIndex == index) {
      return;
    }
    setState(() {
      _selectIndex = index;
    });

    if (!isOnTab) {
      _tabController.animateTo(_selectIndex);
    } else {
      ///animateToPage跳转需要一个界面一个界面的跳，比如现在是
      ///1号界面，需要跳转到3号界面，就会导致2号界面的显示，
      ///会导致pageview的onPageChange方法的调用，需要自己处理
      _pageController.animateToPage(_selectIndex,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
      ///等待滑动解锁
      Future.delayed(Duration(milliseconds: 200), () {
        _isOnTab = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    LogUtils.e("build..........$_selectIndex");
    //ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      //PreferredSize设置高度
      appBar: PreferredSize(
        child: AppBar(
          //AppBar下面阴影
          backgroundColor: Colors.red,
          elevation: 0,
          title: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(100)),
            child: TabBar(
              onTap: (index) {
                _isOnTab = true;
                _onTabPageChange(index, isOnTab: true);
              },
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              //labelStyle的设置导致滑动时字体闪烁
//                labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
//                unselectedLabelStyle: TextStyle(fontSize: 14),
              indicatorColor: Colors.transparent,
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text("我的",
                      style: _selectIndex == 0 ? _selectStyle : _defaultStyle),
                ),
                Tab(
                  child: Text("发现",
                      style: _selectIndex == 1 ? _selectStyle : _defaultStyle),
                ),
                Tab(
                  child: Text("云村",
                      style: _selectIndex == 2 ? _selectStyle : _defaultStyle),
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size(ScreenUtil.screenWidth, ScreenUtil().setHeight(80)),
      ),
      backgroundColor: Colors.white,
      //SafeArea 对于异形界面手机显示时处理越界啥的
      body: SafeArea(
        //底部异常
        bottom: false,
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  if (!_isOnTab) {
                    LogUtils.e("onPageChanged.......");
                    _onTabPageChange(index, isOnTab: false);
                  }
                },
                controller: _pageController,
                children: <Widget>[
                  Center(
                      child: Container(
                    height: ScreenUtil.screenHeight,
                    width: ScreenUtil.screenWidth,
                    decoration: BoxDecoration(color: Colors.yellow),
                    child: Text("我的"),
                  )
                      //Text("我的"),
                      ),
                  Center(
                      child: Container(
                    height: ScreenUtil.screenHeight,
                    width: ScreenUtil.screenWidth,
                    decoration: BoxDecoration(color: Colors.green),
                    child: Text("发现"),
                  )),
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
}

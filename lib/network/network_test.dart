import 'dart:convert' show json;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/image/data.dart';
import 'package:flutter_study/utils/log_util.dart';
import 'package:flutter_study/widget/loading_view.dart';

class NetworkTest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NetworkTestState();
  }

}

class NetworkTestState extends State<NetworkTest>{
  String _text = "暂无数据";

  getBanner(BuildContext context) async{
      LoadingView.showLoading(context);
      Response response = await Dio().get("https://music.163.com/api/v2/banner/get?clientType=android");
      String data = response.data;
      LogUtils.e("data:$data");
      BannerWarp item = BannerWarp.fromJson(json.decode(data));
      LogUtils.e("获取到的数据：${item.banners[0].toString()}");
      setState(() {
        _text = item.banners[0].toString();
      });
      LoadingView.hideLoading(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "网络测试"
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
              MaterialButton(
                child: Text("获取数据"),
                onPressed: (){
                    getBanner(context);
                },
              ),
            Container(
              child: Text(_text),
            )
          ],
        ),
      ),
    );
  }

}
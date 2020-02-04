import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/router/routes.dart';

import '../application.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FirstPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("firstText"),
            MaterialButton(
              child: Text("进去第二个界面"),
              onPressed: () {
                Application.router.navigateTo(context, Routes.secondPage);
                //Navigator.of(context).pushNamed(Routes.secondPage);
              },
            )
          ],
        ),
      ),
    );
  }
}

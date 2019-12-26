import 'package:bookkeeping/res/colours.dart';
import 'package:bookkeeping/settings/category_editor.dart';
import 'package:bookkeeping/settings/settings_router.dart';
import 'package:bookkeeping/widgets/app_bar.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bookkeeping/util/fluro_navigator.dart';
import 'package:oktoast/oktoast.dart';


class Person extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBar(
        barStyle: StatusBarStyle.light,
        backgroundColor: Colors.white.withOpacity(1.0),
        isBack: false,
        titleWidget: new Text("我的账户",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: new Container(
        color: Colours.bg_color,
        child: new Column(
          children: <Widget>[
            _buildButton("我的", 30, (){
              showToast("待实现");
            }),
          ],
        ),
      ),
    );
  }


  Widget _buildButton(
      String title,
      double marginTop,
      void Function() onPressed) {
    return new Container(
      child: CupertinoButton(
        child: new Text(title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        color: Colors.white,
        onPressed: onPressed,
        pressedOpacity: 0.5,
        borderRadius: BorderRadius.zero,
      ),
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0, marginTop, 0, 0),
    );
  }

}
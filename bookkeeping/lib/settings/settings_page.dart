import 'package:bookkeeping/res/colours.dart';
import 'package:bookkeeping/settings/category_editor.dart';
import 'package:bookkeeping/settings/settings_router.dart';
import 'package:bookkeeping/widgets/app_bar.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bookkeeping/util/fluro_navigator.dart';


class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBar(
        barStyle: StatusBarStyle.light,
        backgroundColor: Colors.white.withOpacity(1.0),
        isBack: false,
        titleWidget: new Text("设置",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: new Container(
        color: Colours.bg_color,
        child: new Column(
          children: <Widget>[
            _buildButton("支出类别设置", 30, (){
              NavigatorUtils.push(
                  context,
                  SettingsRouter.expenCategory,
                  transition: TransitionType.cupertinoFullScreenDialog);
            }),
            _buildButton("收入类别设置", 2, (){
              NavigatorUtils.push(
                  context,
                  SettingsRouter.incomeCategory,
                  transition: TransitionType.cupertinoFullScreenDialog);
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
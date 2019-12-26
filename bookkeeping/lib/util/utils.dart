import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class Utils {
  static String getImagePath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static KeyboardActionsConfig getKeyboardActionsConfig(List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: List.generate(
          list.length,
          (i) => KeyboardAction(
                focusNode: list[i],
                closeWidget: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text("关闭"),
                ),
              )),
    );
  }

  static String formatDouble(double toFormat) {
    return (toFormat * 10) % 10 != 0 ? "$toFormat" : "${toFormat.toInt()}";
  }

  static Future<List<String>> loadCategoryIcons() async {
    var json = await rootBundle.loadString('assets/data/category.json');
    List list = jsonDecode(json);
    List<String> icons = new List<String>();
    list.forEach((value) {
      var items = value["items"];
      if (items != null && items is List) {
        items.forEach((item) {
          icons.add(item["image"]);
        });
      }
    });
    return icons;
  }
}

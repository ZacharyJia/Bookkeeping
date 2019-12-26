import 'dart:async';

import 'package:bookkeeping/res/styles.dart';
import 'package:bookkeeping/util/fluro_navigator.dart';
import 'package:bookkeeping/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'highlight_well.dart';

typedef void Confirm(String text, String image);

class CategoryEditDialog extends StatefulWidget {
  const CategoryEditDialog(
      {Key key, this.confirm, this.title, this.text, this.image})
      : super(key: key);

  final Confirm confirm;
  final String title;
  final String text;
  final String image;

  @override
  State<StatefulWidget> createState() => CategoryEditDialogState();
}

class CategoryEditDialogState extends State<CategoryEditDialog> {
  TextEditingController _editingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusScopeNode _scopeNode;
  Timer _timer;
  List<String> _categoryIcons = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _editingController.text = widget.text;
    Utils.loadCategoryIcons().then((value) {
      this._categoryIcons = value;
      _selectedIndex = _categoryIcons.indexOf(widget.image);
      if (_selectedIndex == -1) _selectedIndex = 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(160)),
          child: Container(
            width: ScreenUtil.getInstance().setWidth(560),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.title,
                    style:
                        TextStyle(fontSize: ScreenUtil.getInstance().setSp(32)),
                  ),
                ),
                _buildCategoryIcons(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    onSubmitted: (text) {
                      if (widget.confirm != null) {
                        widget.confirm(text, _categoryIcons[_selectedIndex]);
                      }
                      NavigatorUtils.goBack(context);
                    },
                    controller: _editingController,
                    focusNode: _focusNode,
                    maxLines: 2,
                    style:
                        TextStyle(fontSize: ScreenUtil.getInstance().setSp(32)),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        hintText: '类别名称', border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: 49,
                  child: Stack(
                    children: <Widget>[
                      Gaps.line,
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: HighLightWell(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '取消',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              onTap: () {
                                NavigatorUtils.goBack(context);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: HighLightWell(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '确认',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              onTap: () {
                                if (widget.confirm != null) {
                                  widget.confirm(_editingController.text,
                                      _categoryIcons[_selectedIndex]);
                                }
                                NavigatorUtils.goBack(context);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 支出构建
  _buildCategoryIcons() {
    return SizedBox(
      height: ScreenUtil.getInstance().setHeight(300),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: GridView.builder(
          key: PageStorageKey<String>("0"), //保存状态
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              childAspectRatio: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8),
          itemCount: _categoryIcons.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Image.asset(
                Utils.getImagePath('category/${_categoryIcons[index]}'),
                color: _selectedIndex == index ? Colors.blue : Colors.black,
              ),
              onTap: () {
                _selectedIndex = index;
                setState(() {});
              },
            );
          },
        ),
      ),
    );
  }
}

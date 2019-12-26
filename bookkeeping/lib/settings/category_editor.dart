import 'package:bookkeeping/bill/models/category_model.dart';
import 'package:bookkeeping/db/db_helper.dart';
import 'package:bookkeeping/res/colours.dart';
import 'package:bookkeeping/routers/fluro_navigator.dart';
import 'package:bookkeeping/util/utils.dart';
import 'package:bookkeeping/widgets/app_bar.dart';
import 'package:bookkeeping/widgets/category_edit_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

enum CategoryType {
  expense,
  income,
}

class CategoryEditor extends StatefulWidget {
  const CategoryEditor({this.categoryType});

  final CategoryType categoryType;

  @override
  State<StatefulWidget> createState() {
    return _CategoryEditorState();
  }
}

class _CategoryEditorState extends State<CategoryEditor> {
  /// 支出类别数组
  List<CategoryItem> _categories = List();

  final String expenTitle = "支出类别设置";
  final String incomeTitle = "收入类别设置";

  @override
  void initState() {
    super.initState();
    if (widget.categoryType == CategoryType.expense) {
      _loadExpenDatas();
    } else {
      _loadIncomeDatas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        barStyle: StatusBarStyle.light,
        backgroundColor: Colors.white.withOpacity(1.0),
        isBack: false,
        titleWidget: new Text(
          widget.categoryType == CategoryType.expense
              ? expenTitle
              : incomeTitle,
          style: TextStyle(color: Colors.black),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 18),
          child: Icon(
            Icons.close,
            color: Colours.app_main,
          ),
          onPressed: () {
            NavigatorUtils.goBack(context);
          },
        ),
        trailing: CupertinoButton(
          child: Icon(
            Icons.check,
            color: Colours.app_main,
          ),
          onPressed: () {
            dbHelp.updateCategory(_categories, widget.categoryType).then((void _) {
              showToast("保存完成");
              NavigatorUtils.goBack(context);
            });
          },
        ),
      ),
      body: Container(
        color: Colours.bg_color,
        child: ReorderableListView(
          header: Container(
            height: 10,
          ),
          children:
              _categories.map((category) => _buildItem(category)).toList(),
          onReorder: (oldIndex, newIndex) {
            print("$oldIndex ---> $newIndex");
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            var tmp = _categories.removeAt(oldIndex);
            _categories.insert(newIndex, tmp);
            setState(() {});
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return CategoryEditDialog(
                  title: "添加支出类别",
                  text: "",
                  confirm: (name, image) {
                    var item = CategoryItem(name, image, _categories.length);
                    _categories.add(item);
                    setState(() {});
                  },
                );
              });
        },
      ),
    );
  }

  /// 获取支出类别数据
  Future<void> _loadExpenDatas() async {
    dbHelp.getInitialExpenCategory().then((list) {
      List<CategoryItem> models =
          list.map((i) => CategoryItem.fromJson(i)).toList();
      if (_categories.length > 0) {
        _categories.removeRange(0, _categories.length);
      }
      _categories.addAll(models);
      setState(() {});
    });
  }

  /// 获取收入类别数据
  Future<void> _loadIncomeDatas() async {
    dbHelp.getInitialIncomeCategory().then((list) {
      List<CategoryItem> models =
      list.map((i) => CategoryItem.fromJson(i)).toList();
      if (_categories.length > 0) {
        _categories.removeRange(0, _categories.length);
      }
      _categories.addAll(models);

      setState(() {});
    });
  }

  Widget _buildItem(category) {
    return Card(
        color: Colors.white,
        key: Key(category.name),
        child: Dismissible(
          key: Key(category.name),
          child: Container(
              width: double.infinity,
              height: 40,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      Utils.getImagePath('category/${category.image}'),
                      width: 20,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CategoryEditDialog(
                              title: "添加支出类别",
                              text: category.name,
                              image: category.image,
                              confirm: (name, image) {
                                category.name = name;
                                category.image = image;
                                setState(() {});
                              },
                            );
                          });
                    },
                  ),
                  Container(
                    width: 15,
                  ),
                  Center(
                    child: Text(
                      category.name,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Icon(
                      Icons.menu,
                      color: Colours.gray,
                    ),
                  )),
                ],
              )),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              _categories.remove(category);
            }
            setState(() {});
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ));
  }
}

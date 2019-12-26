import 'package:bookkeeping/routers/router_init.dart';
import 'package:bookkeeping/settings/category_editor.dart';
import 'package:fluro/fluro.dart';

class SettingsRouter implements IRouterProvider {
  static String expenCategory = '/settings/expenCategory';
  static String incomeCategory = '/settings/incomeCategory';

  @override
  void initRouter(Router router) {
    router.define(expenCategory,
        handler: Handler(
            handlerFunc: (_, params) => CategoryEditor(
                  categoryType: CategoryType.expense,
                )));
    router.define(incomeCategory,
        handler: Handler(
            handlerFunc: (_, params) => CategoryEditor(
              categoryType: CategoryType.income,
            )));
  }
}

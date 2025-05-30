import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package_common/view/CustomBehavior.dart';

import 'BasePage.dart';
import 'BasePageState.dart';

abstract class BaseColumnState<Page extends BasePage>
    extends BasePageState<Page> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: getBgColor(context),
        appBar: getAppBar(context),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: ScrollConfiguration(
                //拖拉效果去除
                behavior: CustomBehavior(),
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: getChildren(context)),
                ))));
  }

  PreferredSizeWidget? getAppBar(BuildContext context) {
    return null;
  }

  Color getBgColor(BuildContext context);

  List<Widget> getChildren(BuildContext context);

  double? getColumnHeight(BuildContext context) {
    return null;
  }
}

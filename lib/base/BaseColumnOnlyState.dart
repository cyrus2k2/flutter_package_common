import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package_common/view/CustomBehavior.dart';

import 'BasePage.dart';
import 'BasePageState.dart';

abstract class BaseColumnOnlyState<Page extends BasePage>
    extends BasePageState<Page> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: getBgColor(context),
        appBar: getAppBar(context),
        body: Container(
          width: double.infinity,
          height: getColumnHeight(context),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: getMainAxisAlignment(),
              crossAxisAlignment: getCrossAxisAlignment(),
              children: getChildren(context)),
        ));
  }

  PreferredSizeWidget? getAppBar(BuildContext context) {
    return null;
  }

  Color getBgColor(BuildContext context);

  List<Widget> getChildren(BuildContext context);

  double? getColumnHeight(BuildContext context) {
    return null;
  }

  MainAxisAlignment getMainAxisAlignment() {
    return MainAxisAlignment.start;
  }

  CrossAxisAlignment getCrossAxisAlignment() {
    return CrossAxisAlignment.center;
  }
}

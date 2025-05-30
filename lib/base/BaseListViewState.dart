import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package_common/view/CustomBehavior.dart';

import 'BasePage.dart';
import 'BasePageState.dart';

abstract class BaseListViewState<Page extends BasePage>
    extends BasePageState<Page> {
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Color? _bgColor = getBgColor(context);

    return Scaffold(
      backgroundColor: _bgColor == null ? Colors.white : _bgColor,
      appBar: getAppBar(context),
      body: _getBody(),
    );
  }

  PreferredSizeWidget? getAppBar(BuildContext context) {
    return null;
  }

  Widget? getEmptyView(BuildContext context) {
    return null;
  }

  Color? getBgColor(BuildContext context) {
    return null;
  }

  Color? getListViewColor(BuildContext context) {
    return null;
  }

  int getItemCount(BuildContext context);

  Widget getItem(BuildContext context, int position);

  Widget? _getBody() {
    Color? _bgColor = getListViewColor(context);

    return isEmpty
        ? getEmptyView(context)
        : ScrollConfiguration(
            //拖拉效果去除
            behavior: CustomBehavior(),
            child: Container(
                color: _bgColor == null ? Colors.white : _bgColor,
                child: ListView.separated(
                    shrinkWrap: true,
                    reverse: false,
                    dragStartBehavior: DragStartBehavior.down,
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: getItemCount(context),
                    itemBuilder: (BuildContext context, int position) {
                      // return _getRow(_devices[position] as BluetoothDevice);
                      return getItem(context, position);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      Divider? divider = getCellDivider(context, index);

                      return divider == null
                          ? Divider(
                              height: 0,
                              color: Colors.transparent,
                            )
                          : divider;
                    })));
  }

/*
Divider(
                        height: 0,
                        color: Colors.transparent,
                      );
 */

  Divider? getCellDivider(BuildContext context, int index) {
    return null;
  }
}

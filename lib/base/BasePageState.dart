import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'BasePage.dart';

import 'package:flutter_package_common/extension/LogExtension.dart';

abstract class BasePageState<Page extends BasePage> extends State<Page> {
  // _showToast(String msg, Toast toastLength) {
  //   Fluttertoast.showToast(
  //       msg: msg, gravity: ToastGravity.CENTER, toastLength: toastLength);
  // }

  refresh(Function() function) => setState(function);

  // showLongToast(String msg) {
  //   this._showToast(msg, Toast.LENGTH_LONG);
  // }

  // showShortToast(String msg) {
  //   this._showToast(msg, Toast.LENGTH_SHORT);
  // }

  printLog(String printMsg) {
    // SimpleLog.printLog(printMsg);
    this.printX(printMsg);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_package_common/dialog/TimePickDialog.dart';

import 'DatePickDialog.dart';
import 'LoadingDialog.dart';
import 'ProgressDialog.dart';
import 'SinglePickDialog.dart';

class DialogUtil {
  DialogUtil._();

  // static void showMyMaterialDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return new AlertDialog(
  //           title: new Text("title"),
  //           content: new Text("内容内容内容内容内容内容内容内容内容内容内容"),
  //           actions: <Widget>[
  //             new FlatButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: new Text("确认"),
  //             ),
  //             new FlatButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: new Text("取消"),
  //             ),
  //           ],
  //         );
  //       });
  // }

  // static void showOTADialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return new AlertDialog(
  //             title: null, content: _getOTAContent(), actions: null);
  //       });
  // }

  // static void showQuitDialog(BuildContext context,
  //     {required Function() onConfirm, required Function() onCancel}) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return new AlertDialog(
  //           title: null,
  //           content: new Text("退出当前程序"),
  //           actions: <Widget>[
  //             new FlatButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 if (null != onConfirm) {
  //                   onConfirm.call();
  //                 }
  //               },
  //               child: new Text("确认"),
  //             ),
  //             new FlatButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 if (null != onCancel) {
  //                   onConfirm.call();
  //                 }
  //               },
  //               child: new Text("取消"),
  //             ),
  //           ],
  //         );
  //       });
  // }

  // static void showDisconDialog(BuildContext context,
  //     {required Function() onConfirm, required Function() onCancel}) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return new AlertDialog(
  //           title: null,
  //           content: new Text("断开当前设备"),
  //           actions: <Widget>[
  //             new FlatButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 if (null != onConfirm) {
  //                   onConfirm.call();
  //                 }
  //               },
  //               child: new Text("确认"),
  //             ),
  //             new FlatButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 if (null != onCancel) {
  //                   onCancel.call();
  //                 }
  //               },
  //               child: new Text("取消"),
  //             ),
  //           ],
  //         );
  //       });
  // }

  // static void showInputDialog(BuildContext context,
  //     {required Function(String input) onConfirm,
  //     required Function() onCancel}) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         // return SizedBox(
  //         //   child: AlertDialog(
  //         //       title: null,
  //         //       content: _getInputTextField(),
  //         //       actions: <Widget>[
  //         //         // FlatButton(
  //         //         //     child: Text("取消"),
  //         //         //     onPressed: () {
  //         //         //       Navigator.pop(context, "cancel");
  //         //         //       if (onCancel != null) {
  //         //         //         onCancel.call();
  //         //         //       }
  //         //         //     }),
  //         //         // FlatButton(
  //         //         //     child: Text("确定"),
  //         //         //     onPressed: () {
  //         //         //       Navigator.pop(context, "yes");
  //         //         //       if (onConfirm != null) {
  //         //         //         onConfirm.call("what");
  //         //         //       }
  //         //         //     }),
  //         //       ]),
  //         // );
  //         return SizedBox(
  //           width: double.infinity,
  //           height: 300,
  //           child: Scaffold(
  //             backgroundColor: Colors.white,
  //             appBar: _getSimpleAppBar("我爱北京天安门"),
  //             body: DatePickDialog(
  //               title: "aaa",
  //               selectCallback: (DateTime) {},
  //             ), //_getInputTextField()
  //           ),
  //         );
  //       });
  // }

  static void showLoadingDialog(BuildContext context, String loadingText,
      {Key? key,
      Color bgColor = Colors.white,
      Color valueColor = Colors.blueAccent,
      bool barrierDismissible = true,
      bool canPopDismiss = true}) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.fromLTRB(80, 0, 80, 0),
              child: WillPopScope(
                  onWillPop: () => Future.value(canPopDismiss),
                  child: LoadingDialog(loadingText, bgColor, valueColor,
                      key: key)));
        });
  }

  static void showProgressDialog(
      BuildContext context, String loadingText, double progressValue,
      {Color bgColor = Colors.white,
      Color progressBgColor = Colors.black12,
      Color progressColor = Colors.greenAccent,
      bool canPopDismiss = true,
      Key? key}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              height: 90,
              color: Colors.transparent,
              child: Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: WillPopScope(
                      onWillPop: () => Future.value(canPopDismiss),
                      child: ProgressDialog(
                        loadingText,
                        bgColor,
                        progressValue,
                        progressBgColor,
                        progressColor,
                        key: key,
                      ))));
        });
  }

  static void showAllowDialog(BuildContext context, String? title,
      String? content, String cancelText, String confirmText,
      {Function()? onConfirm,
      Function()? onCancel,
      Color? titleColor,
      Color? contentColor,
      Color? confirmColor,
      Color? cancelColor}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            insetAnimationDuration: Duration.zero,
            title: title == null
                ? null
                : Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          color:
                              titleColor == null ? Colors.black26 : titleColor),
                    ),
                  ),
            content: content == null
                ? null
                : Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      content,
                      style: TextStyle(
                          fontSize: 15,
                          color: contentColor == null
                              ? Colors.black26
                              : contentColor),
                    ),
                  ),
            actions: [
              TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    Navigator.pop(context);
                    onCancel!.call();
                  },
                  child: Text(
                    cancelText,
                    style: TextStyle(
                        fontSize: 15,
                        color: cancelColor == null
                            ? Color.fromRGBO(0x66, 0x66, 0x66, 1)
                            : cancelColor),
                  )),
              TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm!.call();
                  },
                  child: Text(confirmText,
                      style: TextStyle(
                          fontSize: 15,
                          color: confirmColor == null
                              ? Color.fromRGBO(0x07, 0xCD, 0x8E, 1)
                              : confirmColor)))
            ],
          );
        });
  }

  static void showDatePickerDialog(
      BuildContext context,
      String title,
      String yearText,
      String monthText,
      String dayText,
      String cancelText,
      String confirmText,
      DateTime? initDateTime,
      int minYear,
      Function(DateTime)? selectCallback) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return DatePickDialog(
            title,
            yearText,
            monthText,
            dayText,
            cancelText,
            confirmText,
            initDateTime: initDateTime,
            minYear: minYear,
            selectCallback: selectCallback,
          );
        });
  }

  static void showTimePickerDialog(
    BuildContext context,
    String title,
    String cancelText,
    String confirmText,
    int currentHour,
    int currentMin,
    Function(int hour, int min)? selectCallback,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return TimePickDialog(
            title,
            cancelText,
            confirmText,
            currentHour,
            currentMin,
            selectCallback: selectCallback,
          );
        });
  }

  static void showListBottom(
      BuildContext context,
      String title,
      String? unitText,
      int initSelect,
      String cancelText,
      String confirmText,
      Function(int)? selectCallback,
      List<String> childArray) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return SinglePickDialog(
            title,
            childArray,
            cancelText,
            confirmText,
            initSelect: initSelect,
            unitText: unitText,
            selectCallback: selectCallback,
          );
        });
  }

  static AppBar _getSimpleAppBar(String title,
      {TextAlign? textAlign, Color? titleColor}) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: titleColor),
        textAlign: null == textAlign ? TextAlign.left : textAlign,
      ),
      centerTitle: null != textAlign,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
//elevation: 0, // appbar阴影
    );
  }

  static Widget _getInputTextField() {
    return TextField(
        onChanged: (text) {},
//  controller: TextEditingController(text: 'admin'),
        decoration: InputDecoration(
          border: InputBorder.none,
//去掉输入框的下滑线
          fillColor: Color.fromRGBO(0xf2, 0xf3, 0xf6, 1),
          filled: true,
//hintText: S.of(context).login_name_hint,
          hintStyle: TextStyle(
              color: Color.fromRGBO(0x99, 0x99, 0x99, 1), fontSize: 16.0),
          contentPadding: EdgeInsets.all(5.0),
          enabledBorder: _outlineInputBorder,
          disabledBorder: _outlineInputBorder,
          focusedBorder: _outlineInputBorder,
          focusedErrorBorder: _outlineInputBorder,
          errorBorder: _outlineInputBorder,
        ),
        maxLines: 1,
        inputFormatters: [LengthLimitingTextInputFormatter(20)],
        textAlign: TextAlign.center);
  }

  static final OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    gapPadding: 0,
    borderRadius: BorderRadius.circular(50),
    borderSide:
        BorderSide(color: Color.fromRGBO(0xf2, 0xf3, 0xf6, 1), width: 2),
  );

/* static void showOTADialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              child: new AlertDialog(
                title: null,
                content: _getOTAContent(),
                actions: <Widget>[
                  FlatButton(
                      child: Text("取消"),
                      onPressed: () => Navigator.pop(context, "cancel")),
                  FlatButton(
                      child: Text("确定"),
                      onPressed: () => Navigator.pop(context, "yes")),
                ],
              ),
              onWillPop: () {
                return Future.value(false); //false 为拦截返回键
              });
        },
        barrierDismissible: false,
        useRootNavigator: true,
        useSafeArea: true);
  }

  static Widget _getOTAContent() {
    return Container(
        width: 200,
        height: 300,
        color: Colors.white,
        child: new Column(
          children: [
            new Text(
              "22222",
              style: new TextStyle(color: Colors.red),
            ),
            new SizedBox(
              //限制进度条的高度
              height: 3.0,
              //限制进度条的宽度
              width: 200,
              child: new LinearProgressIndicator(
                  //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                  value: 0.8,
                  //背景颜色
                  backgroundColor: Colors.yellow,
                  //进度颜色
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.lightBlue)),
            )
          ],
        ));
  }*/
}

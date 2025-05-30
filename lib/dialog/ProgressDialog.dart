import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_package_common/base/BasePage.dart';
import 'package:flutter_package_common/base/BasePageState.dart';

class ProgressDialog extends BasePage {
  final String loadingText;
  final Color bgColor;
  final Color progressBgColor;
  final Color progressColor;

  final double progressValue;

  ProgressDialog(
    this.loadingText,
    this.bgColor,
    this.progressValue,
    this.progressBgColor,
    this.progressColor, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoadingDialogState();
  }
}

class LoadingDialogState extends BasePageState<ProgressDialog> {
  double _progress = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progress = widget.progressValue;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
//背景
          color: widget.bgColor,
//设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(12)),
//设置四周边框
          border: new Border.all(
            width: 0,
            color: widget.bgColor,
          )),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 24, 0, 10),
            child: Text(
              widget.loadingText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(0x66, 0x66, 0x66, 1)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: widget.progressBgColor, // 背景色为黑色
              valueColor: AlwaysStoppedAnimation<Color>(
                  widget.progressColor), // 进度条颜色为粉色
            ),
          )
        ],
      ),
    );
  }

  void dismiss() {
    Navigator.pop(context);
  }

  void setProgress(double progress) {
    setState(() {
      _progress = progress;
    });
  }
}

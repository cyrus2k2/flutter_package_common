import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_package_common/base/BasePage.dart';
import 'package:flutter_package_common/base/BasePageState.dart';

class LoadingDialog extends BasePage {
  final String loadingText;
  final Color bgColor;
  final Color valueColor;

  LoadingDialog(this.loadingText, this.bgColor, this.valueColor, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoadingDialogState();
  }
}

class LoadingDialogState extends BasePageState<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 210,
      // height: 90,
      constraints: BoxConstraints(minHeight: 90, maxHeight: 120),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 25,
            height: 25,
            margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(widget.valueColor),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 8, 0, 10),
            child: Text(
              widget.loadingText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, color: Color.fromRGBO(0x66, 0x66, 0x66, 1)),
            ),
          )
        ],
      ),
    );
  }

  void dismiss() {
    Navigator.pop(context);
  }
}

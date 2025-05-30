import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_package_common/base/BasePage.dart';
import 'package:flutter_package_common/base/BasePageState.dart';
import 'package:flutter_package_common/view/CustomBehavior.dart';

import 'package:flutter_package_common/extension/DialogExtension.dart';

class SinglePickDialog extends BasePage {
  SinglePickDialog(
    this.title,
    this.childArray,
    this.cancelText,
    this.confirmText, {
    Key? key,
    this.initSelect = 0,
    this.unitText,
    this.selectCallback,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final int initSelect;
  final String? unitText;

  final String cancelText;
  final String confirmText;

  final Function(int)? selectCallback;

  final List<String> childArray;

  @override
  _SinglePickDialog createState() => _SinglePickDialog();
}

class _SinglePickDialog extends BasePageState<SinglePickDialog> {
  final itemExtent = 50.0;
  final MAX_YEAR_COUNT = 100;

  int _selectIndex = 0;

  FixedExtentScrollController? _singleScrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _singleScrollController = FixedExtentScrollController(
        initialItem: _selectIndex = widget.initSelect);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
      decoration: createItemBg(),
      height: 260,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
            child: _buildPicker(),
            flex: 1,
          ),
          _getBottomBtn()
        ],
      ),
    );

    CupertinoDatePicker aaa;
  }

  Widget _buildPicker() {
    return ScrollConfiguration(
        //拖拉效果去除
        behavior: CustomBehavior(),
        child: CupertinoPicker.builder(
          scrollController: _singleScrollController,
          //backgroundColor: Colors.lightGreenAccent,
          selectionOverlay: _sectionItem(),
          useMagnifier: false,
          itemExtent: itemExtent,
          // diameterRatio: 0,
          //scrollController: ,
          childCount: widget.childArray.length,
          onSelectedItemChanged: (position) {
            //print('The position is $position');
            setState(() {
              _selectIndex = position;
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return _getChildItem(
                widget.childArray[index], _selectIndex == index);
          },
        ));
  }

  Widget _getChildItem(String text, bool isSelect) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18,
            color: isSelect
                ? Color.fromRGBO(0x07, 0xCD, 0x8E, 0.9)
                : Color.fromRGBO(0x99, 0x99, 0x99, 0.8)),
      ),
    );
  }

  // Widget _getText(String text) {
  //   return Text(
  //     text,
  //     style: TextStyle(fontSize: 12, color: Colors.black26),
  //   );
  // }

  Widget _sectionItem() {
    return Container(
        height: itemExtent,
        child: Stack(
          children: [
            Align(
              child: Divider(
                height: 0.2,
                color: Color.fromRGBO(0xEE, 0xEE, 0xEE, 1),
              ),
              alignment: Alignment.topCenter,
            ),
            Align(
              child: Divider(
                height: 0.2,
                color: Color.fromRGBO(0xEE, 0xEE, 0xEE, 1),
              ),
              alignment: Alignment.bottomCenter,
            ),
            if (widget.unitText != null)
              Align(
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      widget.unitText!,
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(0x07, 0xCD, 0x8E, 0.9)),
                    )),
                alignment: Alignment.centerRight,
              )
          ],
        ));
  }

  Widget _getBottomBtn() {
    return Container(
      height: 50,
      // color: ColorConfig.Color_default_bg,
      decoration: BoxDecoration(
          //背景
          color: Color.fromRGBO(0xF6, 0xF7, 0xF9, 0.6),
          //设置四周圆角 角度
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          //设置四周边框
          border: new Border.all(
            width: 0,
            color: Colors.white,
          )),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  widget.cancelText,
                  style: TextStyle(
                      fontSize: 16, color: Color.fromRGBO(0x66, 0x66, 0x66, 1)),
                )),
            flex: 1,
          ),
          Container(
            width: 0.5,
            height: double.infinity,
            color: Colors.black12,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          ),
          Expanded(
            child: TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  Navigator.pop(context);
                  if (null != widget.selectCallback) {
                    widget.selectCallback!.call(_selectIndex);
                  }
                },
                child: Text(widget.confirmText,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(0x07, 0xCD, 0x8E, 1)))),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

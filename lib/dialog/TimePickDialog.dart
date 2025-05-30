import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_package_common/base/BasePage.dart';
import 'package:flutter_package_common/base/BasePageState.dart';
import 'package:flutter_package_common/config/ColorConfig.dart';
import 'package:flutter_package_common/view/CustomBehavior.dart';

import 'package:flutter_package_common/extension/DialogExtension.dart';

class TimePickDialog extends BasePage {
  TimePickDialog(
    this.title,
    this.cancelText,
    this.confirmText,
    this.currentHour,
    this.currentMin, {
    Key? key,
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
  final String cancelText;
  final String confirmText;

  final int currentHour;
  final int currentMin;

  final Function(int hour, int min)? selectCallback;

  @override
  _DatePickDialog createState() => _DatePickDialog();
}

class _DatePickDialog extends BasePageState<TimePickDialog> {
  final itemExtent = 50.0;

  int _selectHour = 0;
  int _selectMin = 0;

  bool _isHourPickerScrolling = false;
  bool _isMinPickerScrolling = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectHour = widget.currentHour;
    _selectMin = widget.currentMin;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
      decoration: createItemBg(),
      height: 300,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildHourPicker()),
                Expanded(child: _buildMinPicker()),
              ],
            ),
            flex: 1,
          ),
          _getBottomBtn()
        ],
      ),
    );

    CupertinoDatePicker aaa;
  }

  Widget _buildHourPicker() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollStartNotification) {
            _isHourPickerScrolling = true;
          } else if (notification is ScrollEndNotification) {
            _isHourPickerScrolling = false;
            //_pickerDidStopScrolling();
          }
          return false;
        },
        child: ScrollConfiguration(
            //拖拉效果去除
            behavior: CustomBehavior(),
            child: CupertinoPicker.builder(
              scrollController:
                  FixedExtentScrollController(initialItem: _selectHour),
              //backgroundColor: Colors.lightGreenAccent,
              selectionOverlay: _sectionItem(""),
              useMagnifier: false,
              itemExtent: itemExtent,
              // diameterRatio: 0,
              //scrollController: ,
              childCount: 24,
              onSelectedItemChanged: (position) {
                //print('The position is $position');
                setState(() {
                  _selectHour = position;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return _getChildItem("${(index)}", _selectHour == index);
              },
            )));
  }

  Widget _buildMinPicker() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollStartNotification) {
            _isMinPickerScrolling = true;
          } else if (notification is ScrollEndNotification) {
            _isMinPickerScrolling = false;
            //_pickerDidStopScrolling();
          }
          return false;
        },
        child: ScrollConfiguration(
            //拖拉效果去除
            behavior: CustomBehavior(),
            child: CupertinoPicker.builder(
              scrollController:
                  FixedExtentScrollController(initialItem: _selectMin),
              //backgroundColor: Colors.lightGreenAccent,
              selectionOverlay: _sectionItem(""),
              //  useMagnifier: false,
              itemExtent: itemExtent,
              // diameterRatio: 0,
              //scrollController: ,
              childCount: 60,
              onSelectedItemChanged: (position) {
                //print('The position is $position');
                setState(() {
                  _selectMin = position;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return _getChildItem("${(index)}", _selectMin == index);
              },
            )));
  }

  void _animateColumnControllerToItem(
      FixedExtentScrollController controller, int targetItem) {
    controller.animateToItem(
      targetItem,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 100),
    );
  }

  Widget _getChildItem(String text, bool isSelect) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, color: isSelect ? Colors.black26 : Colors.black),
      ),
    );
  }

  Widget _getText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 12, color: Colors.black26),
    );
  }

  Widget _sectionItem(String text) {
    return Container(
        height: itemExtent,
        child: Stack(
          children: [
            Align(
              child: Divider(
                height: 0.5,
                color: Colors.black12,
              ),
              alignment: Alignment.topCenter,
            ),
            Align(
              child: Divider(
                height: 0.5,
                color: Colors.black12,
              ),
              alignment: Alignment.bottomCenter,
            ),
            Align(
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: _getText(text)),
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
          color: ColorConfig.Color_line_color.withOpacity(0.3),
          //设置四周圆角 角度
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          //设置四周边框
          // border: new Border.all(
          //   width: 0,
          //   color: ColorConfig.Color_line_color,
          // )
      ),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  widget.cancelText,
                  style: TextStyle(fontSize: 15, color: Colors.black26),
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
                onPressed: () {
                  Navigator.pop(context);
                  if (null != widget.selectCallback) {
                    widget.selectCallback!.call(_selectHour, _selectMin);
                  }
                },
                child: Text(widget.confirmText,
                    style: TextStyle(
                        fontSize: 15, color: ColorConfig.TextColor_07cd8e))),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

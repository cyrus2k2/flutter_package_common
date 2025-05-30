import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_package_common/base/BasePage.dart';
import 'package:flutter_package_common/base/BasePageState.dart';
import 'package:flutter_package_common/config/ColorConfig.dart';
import 'package:flutter_package_common/view/CustomBehavior.dart';

import 'package:flutter_package_common/extension/DialogExtension.dart';

class DatePickDialog extends BasePage {
  final String title;
  final String yearText;
  final String monthText;
  final String dayText;
  final String cancelText;
  final String confirmText;
  final DateTime? initDateTime;

  final int minYear;

  final Function(DateTime)? selectCallback;

  DatePickDialog(
    this.title,
    this.yearText,
    this.monthText,
    this.dayText,
    this.cancelText,
    this.confirmText, {
    Key? key,
    this.initDateTime,
    this.minYear = 1980,
    this.selectCallback,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _DatePickDialog createState() => _DatePickDialog();
}

class _DatePickDialog extends BasePageState<DatePickDialog> {
  final itemExtent = 50.0;
  final MAX_YEAR_COUNT = 100;

  int _selectYear = 0;
  int _selectMonth = 0;
  int _selectDay = 0;

  bool _isYearPickerScrolling = false;
  bool _isMonthPickerScrolling = false;
  bool _isDayPickerScrolling = false;

  int _minYear = 0;
  int _yearCount = 0;
  int _maxEnableDayCount = 0;

  DateTime _nowTime = DateTime.now();

  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _minYear = widget.minYear;

    _yearCount = _nowTime.year - _minYear + 1;
    if (_yearCount > MAX_YEAR_COUNT) {
      _minYear = _nowTime.year - MAX_YEAR_COUNT;
      _yearCount = MAX_YEAR_COUNT;
    }
    DateTime? selectTime = widget.initDateTime;

    if (selectTime != null) {
      _selectYear = (selectTime.year - _minYear);
      _selectMonth = (selectTime.month - 1);
      _selectDay = (selectTime.day);
    }

    _resetDayCount(dateTime: widget.initDateTime);
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
                Expanded(child: _buildYearPicker()),
                Expanded(child: _buildMonthPicker()),
                Expanded(child: _buildDayPicker()),
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

  Widget _buildYearPicker() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollStartNotification) {
            _isYearPickerScrolling = true;
          } else if (notification is ScrollEndNotification) {
            _isYearPickerScrolling = false;
            //_pickerDidStopScrolling();
            _resetDayCount();
          }
          return false;
        },
        child: ScrollConfiguration(
            //拖拉效果去除
            behavior: CustomBehavior(),
            child: CupertinoPicker.builder(
              scrollController:
                  FixedExtentScrollController(initialItem: _selectYear),
              //backgroundColor: Colors.lightGreenAccent,
              selectionOverlay: _sectionItem(widget.yearText),
              useMagnifier: false,
              itemExtent: itemExtent,
              // diameterRatio: 0,
              //scrollController: ,
              childCount: _yearCount,
              onSelectedItemChanged: (position) {
                //print('The position is $position');
                setState(() {
                  _selectYear = position;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return _getChildItem(
                    "${(_minYear + index)}", _selectYear == index);
              },
            )));
  }

  Widget _buildMonthPicker() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollStartNotification) {
            _isMonthPickerScrolling = true;
          } else if (notification is ScrollEndNotification) {
            _isMonthPickerScrolling = false;
            //_pickerDidStopScrolling();
            _resetDayCount();
          }
          return false;
        },
        child: ScrollConfiguration(
            //拖拉效果去除
            behavior: CustomBehavior(),
            child: CupertinoPicker.builder(
              //backgroundColor: Colors.lightGreenAccent,
              scrollController:
                  FixedExtentScrollController(initialItem: _selectMonth),
              selectionOverlay: _sectionItem(widget.monthText),
              //  useMagnifier: false,
              itemExtent: itemExtent,
              // diameterRatio: 0,
              //scrollController: ,
              childCount: 12,
              onSelectedItemChanged: (position) {
                //print('The position is $position');
                setState(() {
                  _selectMonth = position;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return _getChildItem("${(index + 1)}", _selectMonth == index);
              },
            )));
  }

  Widget _buildDayPicker() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollStartNotification) {
            _isDayPickerScrolling = true;
          } else if (notification is ScrollEndNotification) {
            _isDayPickerScrolling = false;
            //_pickerDidStopScrolling();
            if (_selectDay >= _maxEnableDayCount) {}
          }
          return false;
        },
        child: ScrollConfiguration(
            //拖拉效果去除
            behavior: CustomBehavior(),
            child: CupertinoPicker.builder(
              key: _globalKey,
              scrollController:
                  FixedExtentScrollController(initialItem: _selectDay),
              //backgroundColor: Colors.lightGreenAccent,
              selectionOverlay: _sectionItem(widget.dayText),
              //  useMagnifier: false,
              itemExtent: itemExtent,
              // diameterRatio: 0,
              //scrollController: ,
              childCount: _maxEnableDayCount,
              onSelectedItemChanged: (position) {
                //print('The position is $position');
                setState(() {
                  if (position < _maxEnableDayCount) {
                    _selectDay = position;
                  } else {
                    _selectDay = _maxEnableDayCount - 1;
                    _resetDayCount();
                  }
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return _getChildItem("${(index + 1)}", _selectDay == index);
              },
            )));
  }

  void _resetDayCount({DateTime? dateTime}) {
    DateTime _currentDate = dateTime == null
        ? DateTime(_selectYear + _minYear, _selectMonth + 2, 1)
        : dateTime;
    _currentDate = _currentDate.subtract(Duration(days: 1));


    this.printLog("_currentDate  ${_currentDate}");

    setState(() {
      _maxEnableDayCount = _currentDate.day;
      if (_selectDay > _maxEnableDayCount - 1) {
        _selectDay = _maxEnableDayCount - 1;

        if (_globalKey.currentWidget == null) {
          return;
        }

        CupertinoPicker? cupertinoPicker =
            _globalKey.currentWidget as CupertinoPicker?;

        if (cupertinoPicker?.scrollController != null) {
          _animateColumnControllerToItem(
              cupertinoPicker?.scrollController as FixedExtentScrollController,
              _selectDay);
        }
      }
    });
  }

  DateTime _createSelectTime() {
    return DateTime(_selectYear + _minYear, _selectMonth + 1, _selectDay + 1);
  }

  void _animateColumnControllerToItem(
      FixedExtentScrollController controller, int targetItem) {
    controller.animateToItem(
      targetItem,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 1),
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
          color: Color.fromRGBO(0xF6, 0xF7, 0xF9, 0.6),
          //设置四周圆角 角度
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          //设置四周边框
          border: new Border.all(
            width: 0,
            color: ColorConfig.Color_line_color.withOpacity(0.1),
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
                      fontSize: 15, color: Color.fromRGBO(0x66, 0x66, 0x66, 1)),
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
                    widget.selectCallback!.call(_createSelectTime());
                  }
                },
                child: Text(widget.confirmText,
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(0x07, 0xCD, 0x8E, 1)))),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

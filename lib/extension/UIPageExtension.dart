import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_package_common/config/ColorConfig.dart';

extension UIPageExtension on State {
  SlideTransition _createTransition(Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }

  Future<dynamic> navPush(Widget nextPage) {
    return Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return nextPage;
    }));
  }

  Future<dynamic> pushReplacement(Widget nextPage) {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return nextPage;
    }));
  }

  /**
   * 默认的标题栏
   */
  AppBar createSimpleAppBar(String title,
      {bool needBack = false, List<Widget>? actions, Widget? leading}) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 18, color: ColorConfig.TextColor_212121),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: leading != null
          ? leading
          : needBack
              ? BackButton(color: Colors.black)
              : null,
      actions: actions,
    );
  }

  /**
   * 背景色
   */
  BoxDecoration createDefaultDecoration(
      {double? radius, Color color = Colors.white}) {
    return createDecoration(radius == null ? 8 : radius, color, 0, color);
  }

  BoxDecoration createDecoration(
      double radius, Color bgColor, double lineWidth, Color lineColor) {
    return BoxDecoration(
        //背景
        color: bgColor,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        //设置四周边框
        border: new Border.all(
          width: lineWidth,
          color: lineColor,
        ));
  }

  /**
   * 附带默认背景色的 竖排控件
   */
  Widget createColumnBg(List<Widget> children,
      {Color? bgColor,
      Color? lineColor,
      EdgeInsets? margin,
      EdgeInsets? padding,
      double? cellHeight,
      double? cellWidth,
      double? radius,
      Function()? onTap}) {
    return GestureDetector(
      child: Container(
        height: cellHeight,
        width: cellWidth,
        decoration: createDecoration(
            radius ?? 10,
            bgColor == null ? Colors.white : bgColor,
            0,
            lineColor == null ? Colors.white : lineColor),
        margin: margin == null ? EdgeInsets.fromLTRB(16, 0, 16, 0) : margin,
        padding: padding == null ? EdgeInsets.fromLTRB(5, 5, 5, 5) : padding,
        child: Column(
          children: children,
        ),
      ),
      onTap: onTap,
    );
  }

  /**
   * 分隔控件 like ios  tableview section
   */
  Widget tableSection(String text,
      {Color bgColor = ColorConfig.Color_default_bg, EdgeInsets? padding}) {
    return Container(
      padding: padding == null ? EdgeInsets.fromLTRB(25, 0, 25, 0) : padding,
      width: double.infinity,
      height: 35,
      color: bgColor,
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 16, color: ColorConfig.TextColor_666666),
      ),
    );
  }

  /**
   * 左右文本和可自定义图标以及 箭头
   */
  Widget tableCell(String leftText, String rightText, bool needArrow,
      {ImageProvider? cellIcon,
      Color? bgColor,
      Color? leftColor,
      double? cellHeight,
      EdgeInsets? margin,
      EdgeInsets? padding,
      bool? needLine,
      Decoration? decoration,
      double? leftFontSize,
      double? rightFontSize,
      Function()? onTap}) {
    return GestureDetector(
      child: Column(children: [
        Container(
            height: cellHeight == null ? 55 : cellHeight,
            width: double.infinity,
            alignment: Alignment.center,
            margin: margin,
            color: decoration != null
                ? null
                : (bgColor == null ? Colors.transparent : bgColor),
            padding:
                padding == null ? EdgeInsets.fromLTRB(10, 0, 10, 0) : padding,
            decoration: decoration,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (cellIcon != null)
                        Container(
                          child: Image(
                            image: cellIcon,
                          ),
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        ),
                      Text(
                        leftText,
                        style: TextStyle(
                            fontSize: leftFontSize == null ? 16 : leftFontSize,
                            color: leftColor == null
                                ? ColorConfig.TextColor_212121
                                : leftColor,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          rightText,
                          style: TextStyle(
                              fontSize:
                                  rightFontSize == null ? 16 : rightFontSize,
                              color: ColorConfig.TextColor_999999,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      if (needArrow)
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: ColorConfig.TextColor_bbbbbb,
                        )
                    ],
                  )
                ])),
        if (needLine == null || needLine) tableCellLine()
      ]),
      onTap: onTap,
    );
  }

  /**
   * 左边上下两行文本 和右边文本 箭头 无图标
   */
  Widget tableCell2(String title, String content, bool needArrow,
      {String? rightText,
      Color? rightColor,
      Color? bgColor,
      EdgeInsets? margin,
      EdgeInsets? padding,
      Function()? onTap,
      Decoration? decoration,
      bool needLine = false}) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
              //height: 80,
              width: double.infinity,
              color: decoration != null
                  ? null
                  : bgColor == null
                      ? Colors.white
                      : bgColor,
              alignment: Alignment.center,
              margin: margin,
              decoration: decoration,
              padding: padding == null
                  ? EdgeInsets.fromLTRB(10, 10, 10, 10)
                  : padding,
              child: Column(
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorConfig.TextColor_212121,
                              decoration: TextDecoration.none),
                        ),
                        Row(
                          children: [
                            if (rightText != null)
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                child: Text(
                                  rightText,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: rightColor == null
                                          ? ColorConfig.TextColor_999999
                                          : rightColor,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            if (needArrow)
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: ColorConfig.TextColor_bbbbbb,
                              )
                          ],
                        ),
                      ]),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    width: double.infinity,
                    child: Text(
                      content,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorConfig.TextColor_999999,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ],
              )),
          if (needLine) tableCellLine(),
        ],
      ),
      onTap: onTap,
    );
  }

  /**
   * 左边上下两个文本 ，右边文本  图标 箭标
   */
  Widget tableCellTwoText(String title, String rightText, bool needArrow,
      {ImageProvider? cellIcon,
      String? content,
      Color? bgColor,
      Color? titleColor,
      Color? contentColor,
      double? cellHeight,
      EdgeInsets? margin,
      EdgeInsets? padding,
      bool? needLine,
      Decoration? decoration,
      double? titleSize,
      double? contentSize,
      double? rightFontSize,
      Function()? onTap}) {
    return GestureDetector(
      child: Container(
          height: cellHeight ?? 55,
          width: double.infinity,
          alignment: Alignment.center,
          margin: margin,
          color: decoration != null ? null : (bgColor ?? Colors.transparent),
          padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: decoration,
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (cellIcon != null)
                      Container(
                        child: Image(
                          image: cellIcon,
                        ),
                        margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      ),
                    Column(
                      textDirection: TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: titleSize ?? 16,
                              color: titleColor ?? ColorConfig.TextColor_212121,
                              decoration: TextDecoration.none),
                        ),
                        if (content != null)
                          Text(
                            content,
                            style: TextStyle(
                                fontSize: contentSize ?? 16,
                                color: contentColor ??
                                    ColorConfig.TextColor_212121,
                                decoration: TextDecoration.none),
                          )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        rightText,
                        style: TextStyle(
                            fontSize: rightFontSize ?? 16,
                            color: ColorConfig.TextColor_999999,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    if (needArrow)
                      const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: ColorConfig.TextColor_bbbbbb,
                      )
                  ],
                )
              ])),
      onTap: onTap,
    );
  }

  /**
   * 左边两行文本 ，选择框
   */
  Widget tableCell2Check(String title, String content, bool checked,
      {Color? bgColor,
      EdgeInsets? margin,
      EdgeInsets? padding,
      ValueChanged<bool?>? onChanged,
      bool needLine = false,
      Decoration? decoration,
      double? cellHeight}) {
    return Column(
      children: [
        Container(
            height: cellHeight == null ? 85 : cellHeight,
            width: double.infinity,
            color: decoration != null
                ? null
                : bgColor == null
                    ? Colors.white
                    : bgColor,
            alignment: Alignment.center,
            margin: margin,
            decoration: decoration,
            padding:
                padding == null ? EdgeInsets.fromLTRB(10, 5, 0, 5) : padding,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorConfig.TextColor_212121,
                              decoration: TextDecoration.none),
                        ),
                        Text(
                          content,
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorConfig.TextColor_999999,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    flex: 8,
                  ),
                  CupertinoSwitch(value: checked, onChanged: onChanged),
                ])),
        if (needLine) tableCellLine()
      ],
    );
  }

  Widget tableCell2Check2(String title, bool checked,
      {Color? bgColor,
      EdgeInsets? margin,
      EdgeInsets? padding,
      ValueChanged<bool?>? onChanged,
      bool needLine = false,
      double? cellHeight,
      Decoration? decoration,
      double? lineHeight,
      double? thickness,
      double? indent,
      double? endIndent,
      Color? lineColor,
      ImageProvider? cellIcon}) {
    return Column(
      children: [
        Container(
            height: cellHeight == null ? 66 : cellHeight,
            width: double.infinity,
            color: decoration == null
                ? bgColor == null
                    ? Colors.white
                    : bgColor
                : null,
            alignment: Alignment.center,
            decoration: decoration,
            margin: margin,
            padding:
                padding == null ? EdgeInsets.fromLTRB(10, 0, 10, 0) : padding,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (cellIcon != null)
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                          child: Image(image: cellIcon),
                        ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      )
                    ],
                  ),
                  CupertinoSwitch(value: checked, onChanged: onChanged)
                ])),
        if (needLine)
          tableCellLine(
              height: lineHeight,
              thickness: thickness,
              indent: indent,
              endIndent: endIndent,
              color: lineColor)
      ],
    );
  }

  /**
   * line view 分隔符
   */
  Divider tableCellLine(
      {double? height,
      double? thickness,
      double? indent,
      double? endIndent,
      Color? color}) {
    // TODO: implement getCellDivider
    return Divider(
      height: height == null ? 0.5 : height,
      thickness: thickness == null ? 0 : thickness,
      endIndent: endIndent == null ? 0 : endIndent,
      indent: indent == null ? 0 : indent,
      color:
          color == null ? ColorConfig.TextColor_bbbbbb.withOpacity(0.5) : color,
    );
  }

  /**
   * 默认纯色按钮
   */
  Widget createTextButton(String buttonText,
      {EdgeInsets? margin,
      EdgeInsets? padding,
      double width = 188,
      double height = 45,
      Color textColor = Colors.white,
      Color? bgColor,
      Color disabledBgColor = Colors.greenAccent,
      double radius = 25,
      double? fontSize,
      Function()? onPressed}) {
    return Container(
      margin: margin,
      padding: padding == null ? EdgeInsets.all(0) : padding,
      width: width,
      height: height,
      child: CupertinoButton(
        child: Text(
          buttonText,
          style: TextStyle(
              color: textColor, fontSize: fontSize == null ? 15 : fontSize),
        ),
        padding: EdgeInsets.all(0),
        //4000a2ea
        disabledColor: disabledBgColor,
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        onPressed: onPressed,
      ),
    );
  }

  /**
   * 图表父框
   */
  Widget createDataView(
      String typeName, String valueText, String targetValue, Widget drawView,
      {Color? typeColor,
      Color? valueColor,
      EdgeInsets? margin,
      ImageProvider? cellIcon}) {
    return createColumnBg([
      SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            if (cellIcon != null)
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                child: Image(image: cellIcon),
              ),
            Text(
              typeName,
              style: TextStyle(
                  fontSize: 18,
                  color: typeColor == null
                      ? ColorConfig.TextColor_212121
                      : typeColor),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              valueText,
              style: TextStyle(
                  fontSize: 24,
                  color: valueColor == null
                      ? ColorConfig.TextColor_212121
                      : valueColor),
            ),
            Text(
              targetValue,
              style:
                  TextStyle(fontSize: 18, color: ColorConfig.TextColor_999999),
            )
          ],
        ),
      ),
      drawView
    ], padding: EdgeInsets.all(10), margin: margin);
  }

  Widget createTableRow(
    InlineSpan textSpan0,
    String typeName0,
    InlineSpan textSpan1,
    String typeName1,
    InlineSpan textSpan2,
    String typeName2, {
    double height = 85,
    Decoration? decoration,
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: decoration,
      margin: margin,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _createTableRowChild(textSpan0, typeName0),
            flex: 1,
          ),
          Expanded(
            child: _createTableRowChild(textSpan1, typeName1),
            flex: 1,
          ),
          Expanded(
            child: _createTableRowChild(textSpan2, typeName2),
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget _createTableRowChild(InlineSpan textSpan, String typeName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(textSpan),
        Container(
          margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
          child: Text(
            typeName,
            style: TextStyle(fontSize: 16, color: ColorConfig.TextColor_999999),
          ),
        )
      ],
    );
  }

  Widget tableInputCell(String leftText, bool needArrow,
      {ImageProvider? cellIcon,
      Color? bgColor,
      Color? leftColor,
      double? cellHeight,
      EdgeInsets? margin,
      EdgeInsets? padding,
      bool? needLine,
      Decoration? decoration,
      ValueChanged<String>? onChanged,
      TextEditingController? textEditingController,
      bool autofocus = false,
      TextInputType keyboardType = TextInputType.emailAddress,
      String? placeholder,
      int maxLen = 20}) {
    return Column(children: [
      Container(
          height: cellHeight == null ? 55 : cellHeight,
          width: double.infinity,
          alignment: Alignment.center,
          margin: margin,
          color: decoration != null
              ? null
              : (bgColor == null ? Colors.transparent : bgColor),
          padding:
              padding == null ? EdgeInsets.fromLTRB(10, 0, 10, 0) : padding,
          decoration: decoration,
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (cellIcon != null)
                      Container(
                        child: Image(
                          image: cellIcon,
                        ),
                        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      ),
                    Text(
                      leftText,
                      style: TextStyle(
                          fontSize: 16,
                          color: leftColor == null
                              ? ColorConfig.TextColor_212121
                              : leftColor,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: CupertinoTextField(
                              //   controller: _getTextEditingController(_inputPwd),
                              controller: textEditingController,
                              decoration: null,
                              placeholder: placeholder,
                              placeholderStyle: TextStyle(
                                  color: ColorConfig.TextColor_999999,
                                  fontSize: 16.0),
                              style: TextStyle(
                                  color: ColorConfig.TextColor_212121,
                                  fontSize: 16.0),
                              clearButtonMode: OverlayVisibilityMode.never,
                              //prefixMode: OverlayVisibilityMode.always,
                              suffixMode: OverlayVisibilityMode.never,
                              suffix: null,
                              onChanged: onChanged,
                              //  controller: TextEditingController(text: 'admin'),
                              textInputAction: TextInputAction.done,
                              keyboardType: keyboardType,
                              // decoration: _getInputDecoration(S.of(context).login_input_pwd_hint),
                              maxLines: 1,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(maxLen)
                              ],
                              textAlign: TextAlign.end),
                        ),
                        flex: 1,
                      ),
                      if (needArrow)
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: ColorConfig.TextColor_bbbbbb,
                        )
                    ],
                  ),
                  flex: 1,
                )
              ])),
      if (needLine == null || needLine) tableCellLine()
    ]);
  }

  TextEditingController getTextEditingController(String input) {
    return TextEditingController.fromValue(TextEditingValue(
        text: input, selection: TextSelection.collapsed(offset: input.length)));
  }

  ImageProvider getImage(String imageName) {
    return AssetImage("assets/images/$imageName");
  }
}

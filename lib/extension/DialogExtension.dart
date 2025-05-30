import 'package:flutter/material.dart';

extension DialogExtension on State {
  Decoration createItemBg({Color bgColor = Colors.white}) {
    return createItemBgWithRadius(12.0, Colors.white, 0, bgColor);
  }

  Decoration createItemBgWithRadius(
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
}

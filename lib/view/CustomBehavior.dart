import 'dart:io';

import 'package:flutter/material.dart';

class CustomBehavior extends ScrollBehavior {
  // @override
  // Widget buildViewportChrome(
  //     BuildContext context, Widget child, AxisDirection axisDirection) {
  //   if (Platform.isAndroid || Platform.isFuchsia) return child;
  //   return super.buildViewportChrome(context, child, axisDirection);
  // }
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          //不显示头部水波纹
          showLeading: false,
          //不显示尾部水波纹
          showTrailing: false,
          axisDirection: axisDirection,
          color: Theme.of(context).colorScheme.secondary,
        );
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
    }
  }
}

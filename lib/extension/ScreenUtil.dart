import 'package:flutter/cupertino.dart';

extension ScreenUtil on State {
  bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 800;
  }

  bool isTablet(BuildContext context) {
    //news.google.com   分为 800 小屏 / 1036 中屏 1440大屏
    //手机或者平板
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 800 && screenWidth < 1036;
  }

  bool isMobileOrTablet(BuildContext context) {
    //news.google.com   分为 800 小屏 / 1036 中屏 1440大屏
    //手机或者平板
    return MediaQuery.of(context).size.width < 1036;
  }

  bool isTabletOrPc(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800;
  }

  bool isPc(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1036;
  }
}

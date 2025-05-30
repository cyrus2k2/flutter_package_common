import 'package:flutter_package_common/extension/LogExtension.dart';

class Config {
  Config._();

  static bool DEBUG = false;

  static const PAGE_SIZE = 20;

  /// //////////////////////////////////////常量////////////////////////////////////// ///
  static checkDebugMode() {
    DEBUG = _isInDebugMode;

    LogExtension.debug = DEBUG;
  }

  static bool get _isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true); //如果debug模式下会触发赋值
    return inDebugMode;
  }
}

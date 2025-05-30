import 'package:flutter/foundation.dart';

class PlatformUtils {
  PlatformUtils._();

  static bool isWeb() {
    return kIsWeb == true;
  }
}

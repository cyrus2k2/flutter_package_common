import 'dart:convert';

import 'dart:typed_data';

class StringUtil {
  StringUtil._();

  /*
  字符串转二进制数组
   */
  static Uint8List string2BinaryList(String input) {
    return Uint8List.fromList(utf8.encode(input));
  }

  /*
   二进制数组转字符串

  */
  static String binaryList2String(Uint8List input, {bool? allowMalformed}) {
    return utf8.decode(input, allowMalformed: allowMalformed);
  }
}

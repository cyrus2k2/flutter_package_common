extension IntExtension on int {
  //转bool
  bool toBool() {
    return this == 0 ? false : true;
  }

  //转16进制
  String toHex() {
    return "0x${toRadixString(16).toUpperCase()}";
  }
}

extension BoolExtension on bool {
  int toInt() {
    return this == true ? 1 : 0;
  }
}

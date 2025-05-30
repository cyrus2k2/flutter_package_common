extension LogExtension on Object {
  static bool debug = false;

  printX(String printMsg) {
    //bool _debug = kDebugMode;
    if (debug) {
      print("${this.toString()} ${printMsg}");
    }
  }

  setDebug(bool _debug) {
    debug = _debug;
  }
}

import '../HttpMethod.dart';

abstract class BaseHttpUtil {
  static const int Default_Time_Out = 10;
  static const int File_Upload_Time_Out = 30;

  static Future<String> doHttp(
      bool isHttps, HttpMethod method, String mainUrl, String endUrl,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      int timeOutDuration = Default_Time_Out,
      bool isWeb = false}) {
    return Future.value(null);
  }
}

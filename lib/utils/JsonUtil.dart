import 'dart:convert';

class JsonUtil {

  JsonUtil._();

  // static Map<String, dynamic> stringToMapWithDecrypt(String data) {
  //   return stringToMap(decryptString(data));
  // }

  // static String decryptString(String data) {
  //   return AesUtil.decryptString(data);
  // }

  static Map<String, dynamic> stringToMap(String json) {
    return JsonDecoder().convert(json);
  }

  static String mapToString(Map<String, dynamic> map) {
    return JsonEncoder().convert(map);
  }

  static String objectToString(Object object) {
    return JsonEncoder().convert(object);
  }
}

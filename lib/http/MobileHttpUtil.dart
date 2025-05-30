import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'HttpMethod.dart';
import 'base/BaseHttpUtil.dart';

import 'package:flutter_package_common/extension/LogExtension.dart';

class MobileHttpUtil extends BaseHttpUtil {
  // static const String _Main_URL = "192.168.1.199:3088";
  // static const String _Middle_URL = "/DeviceOTA/v1";

  // static Future<BaseHttpResponse> login(String userName, String userPwd) async {
  //   return _doHttp(HttpMethod.POST, "/login", {
  //     'userName': userName,
  //     //'userPwd': AesUtil.encryptString(userPwd).toString()
  //     'userPwd': AesUtil.encryptString(userPwd)
  //   });
  // }

  // static Future<BaseHttpResponse> getUserProjects(BuildContext context) {
  //   //UserProvider userProvider = Provide.value<UserProvider>(context);
  //   UserProvider userProvider= context.read<UserProvider>();
  //   if (null == userProvider || null == userProvider.currentUser) {
  //     return null;
  //   }
  //   final Map<String, String> params = {
  //     'token': userProvider.currentUser.token,
  //     //'userPwd': AesUtil.encryptString(userPwd).toString()
  //     'pageIndex': '0',
  //     'pageSize': '100',
  //   };
  //   //Map<String,String>  参数必须是
  //
  //   return _doHttp(HttpMethod.GET, "/user/projects", params);
  //   //.then((value) => _onUserProjectsResult(value, userProvider));
  // }

  /*
   @RequestParam(value = "token", required = true) token: String,
        @RequestParam(value = "projectId", required = true) projectId: Long,
        @RequestParam(value = "pageIndex", required = true) pageIndex: Int,
        @RequestParam(value = "pageSize", required = true) pageSize: Int
   */

  // static Future<BaseHttpResponse> getProjectUpgrade(
  //     BuildContext context, String projectId) {
  //   //UserProvider userProvider = Provide.value<UserProvider>(context);
  //   UserProvider userProvider = context.read<UserProvider>();
  //   if (null == userProvider || null == userProvider.currentUser) {
  //     return null;
  //   }
  //   final Map<String, String> params = {
  //     'token': userProvider.currentUser.token,
  //     'projectId': projectId,
  //     'pageIndex': '0',
  //     'pageSize': '100',
  //   };
  //   //Map<String,String>  参数必须是
  //
  //   return _doHttp(HttpMethod.GET, "/upgrade", params);
  //   //.then((value) => _onUserProjectsResult(value, userProvider));
  // }

  // static Future<BaseHttpResponse> checkDeviceUpgrade(
  //     BuildContext context, String projectId, String deviceVersion) {
  //   UserProvider userProvider = context.read<UserProvider>();
  //   if (null == userProvider || null == userProvider.currentUser) {
  //     return null;
  //   }
  //   final Map<String, String> params = {
  //     'token': userProvider.currentUser.token,
  //     'projectId': projectId,
  //     'deviceVersion': deviceVersion,
  //   };
  //   //Map<String,String>  参数必须是
  //
  //   return _doHttp(HttpMethod.GET, "/upgrade/checkUpgrade", params);
  //   //.then((value) => _onUserProjectsResult(value, userProvider));
  // }

  // static String _getEndUrl(String endUrl) {
  //   return _Middle_URL + endUrl;
  // }

  static Future<String> doHttp(
      bool isHttps, HttpMethod method, String mainUrl, String endUrl,
      {Map<String, dynamic>? parameters,
      Map<String, String>? headers,
      int timeOutDuration = BaseHttpUtil.Default_Time_Out}) {
    return _doMobileHttp(isHttps, method, mainUrl, endUrl,
        parameters: parameters,
        headers: headers,
        timeOutDuration: timeOutDuration);
  }

  static Future<String> _doMobileHttp(
      bool isHttps, HttpMethod method, String mainUrl, String endUrl,
      {Map<String, dynamic>? parameters,
      Map<String, String>? headers,
      int timeOutDuration = BaseHttpUtil.Default_Time_Out}) async {
    final httpClient = HttpClient();
    httpClient.connectionTimeout = Duration(seconds: timeOutDuration);
    //httpClient.printX("_doHttp $endUrl");

    //httpClient.printLog("33333");
    Uri? uri;
    if (isHttps) {
      uri = Uri.https(mainUrl, endUrl, parameters);
    } else {
      // final uri = new Uri.http(mainUrl, endUrl, queryParameters);
      uri = Uri.http(mainUrl, endUrl, parameters);
    }

    HttpClientRequest? request;

    switch (method) {
      case HttpMethod.GET:
        request = await httpClient.getUrl(uri);
        break;
      case HttpMethod.POST:
        request = await httpClient.postUrl(uri);
        break;
      case HttpMethod.PUT:
        request = await httpClient.putUrl(uri);
        break;
      case HttpMethod.DELETE:
        request = await httpClient.deleteUrl(uri);
        break;
      case HttpMethod.PATCH:
        request = await httpClient.patchUrl(uri);
        break;
      case HttpMethod.HEAD:
        request = await httpClient.headUrl(uri);
        break;
    }

    // if (request == null) {
    //   return Future<BaseHttpResponse>(null);
    // }
    if (headers != null) {
      headers.forEach((key, value) {
        request?.headers.add(key, value);
      });
/*
"Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
 */

    } else {
      headers = Map<String, String>();
    }

    request.headers.add("Accept", "application/json");
    request.headers.add("Access-Control_Allow_Origin", "*");

    httpClient.printX("headers ${request.headers}");

    httpClient.printX("uri ${uri.path}");
    httpClient.printX("uri ${uri.toString()}");

    final response = await request.close();
    final responseBody = await response.transform(Utf8Decoder()).join();
    //Map data = JsonDecoder().convert(responseBody);
    // httpClient.printX("responseBody ${responseBody}");
    //  return BaseHttpResponse.fromJson(JsonUtil.stringToMap(responseBody));
    // print("responseBody ${responseBody}");
    return Future.value(responseBody); //responseBody
  }
}

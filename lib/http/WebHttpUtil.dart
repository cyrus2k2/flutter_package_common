import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http; //web和手机端http兼容问题

import 'HttpMethod.dart';
import 'base/BaseHttpUtil.dart';

import 'package:flutter_package_common/extension/LogExtension.dart';

class WebHttpUtil extends BaseHttpUtil {
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
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      int timeOutDuration = BaseHttpUtil.Default_Time_Out}) async {
    return _doWebHttp(isHttps, method, mainUrl, endUrl,
        queryParameters: queryParameters,
        headers: headers,
        timeOutDuration: timeOutDuration);
  }

  static Future<String> pushFileByBytes(bool isHttps, HttpMethod method,
      String mainUrl, String endUrl, List<int> value,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      int timeOutDuration = BaseHttpUtil.Default_Time_Out,
      String field = "file",
      String? fileName}) async {
    return _pushFileByBytes(isHttps, method, mainUrl, endUrl, value,
        queryParameters: queryParameters,
        headers: headers,
        timeOutDuration: timeOutDuration,
        field: field,
        fileName: fileName);
  }

/*
stream should be  http.ByteStream(file.readStream as Stream<List<int>>)
 */
  static Future<String> pushFileByStream(bool isHttps, HttpMethod method,
      String mainUrl, String endUrl, Stream<List<int>> stream, int fileLen,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      int timeOutDuration = BaseHttpUtil.Default_Time_Out,
      String field = "file",
      String? fileName}) async {
    return _pushFileByStream(isHttps, method, mainUrl, endUrl, stream, fileLen,
        queryParameters: queryParameters,
        headers: headers,
        timeOutDuration: timeOutDuration,
        field: field,
        fileName: fileName);
  }

  static Future<String> _doWebHttp(
      bool isHttps, HttpMethod method, String mainUrl, String endUrl,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      int timeOutDuration = BaseHttpUtil.Default_Time_Out}) async {
    // final httpClient = BrowserClient();
    final httpClient = http.Client(); ////web和手机端http兼容问题
    //httpClient.withCredentials = true;
    //httpClient.send(request)
    //httpClient.printX("_doHttp $endUrl");

    //httpClient.printLog("33333");
    Uri? uri;
    if (isHttps) {
      uri = Uri.https(mainUrl, endUrl, queryParameters);
      // if (method == HttpMethod.GET) {
      //   uri = Uri.https(mainUrl, endUrl, queryParameters);
      // } else {
      //   uri = Uri.https(mainUrl, endUrl);
      // }
    } else {
      // final uri = new Uri.http(mainUrl, endUrl, queryParameters);
      uri = Uri.http(mainUrl, endUrl, queryParameters);
      // if (method == HttpMethod.GET) {
      //   uri = Uri.http(mainUrl, endUrl, queryParameters);
      // } else {
      //   uri = Uri.http(
      //     mainUrl,
      //     endUrl,
      //   );
      // }
    }

    httpClient.printX("uri ${uri.path}");
    httpClient.printX("uri ${uri.toString()}");

    //HttpClientRequest? request;
    http.Response? response;

    switch (method) {
      case HttpMethod.GET:
        response = await httpClient
            .get(
              uri,
              headers: headers,
            )
            .timeout(Duration(seconds: timeOutDuration));
        break;
      case HttpMethod.POST:
        response = await httpClient
            .post(uri,
                headers: headers,
                //   body: queryParameters,
                encoding: Encoding.getByName("utf-8"))
            .timeout(Duration(seconds: timeOutDuration));
        break;
      case HttpMethod.PUT:
        response = await httpClient
            .put(uri,
                headers: headers,
                // body: queryParameters,
                encoding: Encoding.getByName("utf-8"))
            .timeout(Duration(seconds: timeOutDuration));
        break;
      case HttpMethod.DELETE:
        response = await httpClient
            .delete(uri,
                headers: headers,
                //  body: queryParameters,
                encoding: Encoding.getByName("utf-8"))
            .timeout(Duration(seconds: timeOutDuration));
        break;
      case HttpMethod.PATCH:
        response = await httpClient
            .patch(uri,
                headers: headers,
                //  body: queryParameters,
                encoding: Encoding.getByName("utf-8"))
            .timeout(Duration(seconds: timeOutDuration));
        break;
      case HttpMethod.HEAD:
        response = await httpClient
            .head(
              uri,
              headers: headers,
              //  body: queryParameters,
              // encoding: Encoding.getByName("utf-8")
            )
            .timeout(Duration(seconds: timeOutDuration));
        break;
    }

    // if (request == null) {
    //   return Future<BaseHttpResponse>(null);
    // }
    // if (headers != null && headers.isNotEmpty) {
    //   headers.forEach((key, value) {
    //     request?.headers.add(key, value);
    //   });
    // }

    //final response = await request.close();
    //  final responseBody = await response.transform(Utf8Decoder()).join();
    final responseBody = response?.body;
    //Map data = JsonDecoder().convert(responseBody);
    // httpClient.printX("responseBody ${responseBody}");
    //  return BaseHttpResponse.fromJson(JsonUtil.stringToMap(responseBody));
    // print("responseBody ${responseBody}");
    httpClient.close();
    return Future.value(responseBody); //responseBody
  }

  static Future<String> _pushFileByBytes(bool isHttps, HttpMethod method,
      String mainUrl, String endUrl, List<int> value,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      int timeOutDuration = BaseHttpUtil.Default_Time_Out,
      String field = "file",
      String? fileName}) async {
    return _pushFileBase(
        isHttps, method, mainUrl, endUrl, _getMultipartFileBytes(value),
        queryParameters: queryParameters,
        headers: headers,
        timeOutDuration: timeOutDuration,
        field: field,
        fileName: fileName); //responseBody
  }

  static Future<String> _pushFileByStream(bool isHttps, HttpMethod method,
      String mainUrl, String endUrl, Stream<List<int>> stream, int fileLen,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      int timeOutDuration = BaseHttpUtil.Default_Time_Out,
      String field = "file",
      String? fileName}) async {
    return _pushFileBase(
        isHttps,
        method,
        mainUrl,
        endUrl,
        _getMultipartFileStream(stream, fileLen,
            field: field, fileName: fileName),
        queryParameters: queryParameters,
        headers: headers,
        timeOutDuration: timeOutDuration,
        field: field,
        fileName: fileName); //responseBody
  }

  static Future<String> _pushFileBase(bool isHttps, HttpMethod method,
      String mainUrl, String endUrl, http.MultipartFile multipartFile,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      int timeOutDuration = BaseHttpUtil.Default_Time_Out,
      String field = "file",
      String? fileName}) async {
    // final httpClient = BrowserClient();
    final httpClient = http.Client(); ////web和手机端http兼容问题
    //httpClient.withCredentials = true;
    //httpClient.send(request)
    //httpClient.printX("_doHttp $endUrl");

    //httpClient.printLog("33333");
    Uri? uri;
    if (isHttps) {
      uri = Uri.https(mainUrl, endUrl, queryParameters);
      // if (method == HttpMethod.GET) {
      //   uri = Uri.https(mainUrl, endUrl, queryParameters);
      // } else {
      //   uri = Uri.https(mainUrl, endUrl);
      // }
    } else {
      // final uri = new Uri.http(mainUrl, endUrl, queryParameters);
      uri = Uri.http(mainUrl, endUrl, queryParameters);
      // if (method == HttpMethod.GET) {
      //   uri = Uri.http(mainUrl, endUrl, queryParameters);
      // } else {
      //   uri = Uri.http(
      //     mainUrl,
      //     endUrl,
      //   );
      // }
    }

    httpClient.printX("uri ${uri.path}");
    httpClient.printX("uri ${uri.toString()}");

    var request = http.MultipartRequest('POST', uri);

    //final mimeType = lookupMimeType(file.filename ?? '');

    // http.mu

    // var multipartFile = http.MultipartFile.fromBytes(
    //   field,
    //   value,
    //   filename: fileName,
    //   // contentType: mimeType == null ? null : MediaType.parse(mimeType),
    // );

    request.files.add(multipartFile);
    if (headers != null) {
      request.headers.addAll(headers);
    }

    //final response = await request.close();
    //  final responseBody = await response.transform(Utf8Decoder()).join();
    final response = await httpClient
        .send(request)
        .timeout(Duration(seconds: timeOutDuration));

    //final responseBody = response.body;
    final body = await response.stream.transform(utf8.decoder).join();

    //Map data = JsonDecoder().convert(responseBody);
    // httpClient.printX("responseBody ${responseBody}");
    //  return BaseHttpResponse.fromJson(JsonUtil.stringToMap(responseBody));
    // print("responseBody ${responseBody}");
    httpClient.close();
    return Future.value(body); //responseBody
  }

  static http.MultipartFile _getMultipartFileBytes(List<int> value,
      {String field = "file", String? fileName}) {
    return http.MultipartFile.fromBytes(
      field,
      value,
      filename: fileName,
      // contentType: mimeType == null ? null : MediaType.parse(mimeType),
    );
  }

  static http.MultipartFile _getMultipartFileStream(
      Stream<List<int>> stream, int fileLen,
      {String field = "file", String? fileName}) {
    return http.MultipartFile(field, stream, fileLen, filename: fileName);
  }

// static _downFile() async {
//   int fileSize;
//   int downloadProgress = 0;
//
//   //http://192.168.1.99:3088/DeviceOTA/v1/upgrade_downloadprojectId=4&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOlsiMSIsImFkbWluIl0sImV4cCI6MTYxMzI2ODgxOX0.wB1RUxSgutYzsjUzdwlR1axl1KZZNC6fsrg91ZE5468&fileName=AAAAA_99.99.11.11_20210115101526.bin
//
//   // new HttpClient().getUrl(url)
//
//   new HttpClient()
//       .get('192.168.1.99', 3088,
//           '/DeviceOTA/v1/upgrade_downloadprojectId=4&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOlsiMSIsImFkbWluIl0sImV4cCI6MTYxMzI2ODgxOX0.wB1RUxSgutYzsjUzdwlR1axl1KZZNC6fsrg91ZE5468&fileName=AAAAA_99.99.11.11_20210115101526.bin')
//       // .getUrl(Uri.file(
//       //     "http://192.168.1.99:3088/DeviceOTA/v1/upgrade_downloadprojectId=4&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOlsiMSIsImFkbWluIl0sImV4cCI6MTYxMzI2ODgxOX0.wB1RUxSgutYzsjUzdwlR1axl1KZZNC6fsrg91ZE5468&fileName=AAAAA_99.99.11.11_20210115101526.bin"))
//       .then((HttpClientRequest request) => request.close())
//       .then((HttpClientResponse response) {
//     // response.length.then((value) => fileSize = value);
//     response.listen((event) {
//       downloadProgress += event.length;
//       // handle data
//       SimpleLog.printLog("downloadProgress ${downloadProgress}  fileSize=${fileSize} ");
//     }).onDone(() {
//       SimpleLog.printLog("下载成功");
//     });
//     // response.length.then((value) => fileSize = value);
//     // response.transform(utf8.decoder).listen((contents) {
//     //   downloadProgress += contents.length;
//     //   // handle data
//     //
//     //   SimpleLog.printLog("downloadProgress ${downloadProgress}  fileSize=${fileSize} ");
//     // }).onError(_onError);
//   });
//
//   // HttpClient client = new HttpClient();
//   // client
//   //     .getUrl(Uri.parse("http://www.example.com/"))
//   //     .then((HttpClientRequest request) {
//   //   // Optionally set up headers...
//   //   // Optionally write to the request object...
//   //   // Then call close.
//   //
//   //   return request.close();
//   // }).then((HttpClientResponse response) {
//   //   // Process the response.
//   // });
// }

// static _downFile(String token, int projectId, String fileName,
//     ProgressCallback onReceiveProgress) async {
//   Dio dio = new Dio();
//   FileUtil fileUtil = new FileUtil();
//
//   Directory _rootDir = Directory(fileUtil.getRootDir());
//
//   File file = new File(_rootDir.path + "/${fileName}");
//   if (file.existsSync()) {
//     file.deleteSync();
//   }
//   file.createSync();
//
//   dio.download(
//       "http://${_Main_URL}${_Middle_URL}/upgrade_downloadprojectId=${projectId}&token=${token}&fileName=${fileName}",
//       file.path,
//       //     onReceiveProgress: (int count, int total) {
//       //   SimpleLog.printLog("count ${count} total=${total} ");
//       //
//       // }
//       onReceiveProgress: onReceiveProgress);
// }
//
// static _onError() {
//   "222".printX("下载失败 _onError");
// }
}

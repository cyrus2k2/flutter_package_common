import 'package:json_annotation/json_annotation.dart';

part 'BaseHttpResponse.g.dart';

/*

  清除缓存
 flutter packages pub run build_runner clean

 flutter packages pub run build_runner build --delete-conflicting-outputs

  运行的命令
 flutter packages pub run build_runner build

flutter packages pub run build_runner build
 */

/*
服务器返回的内容
 */
@JsonSerializable()
class BaseHttpResponse {
  int code = 0;
  String? data;
  String? msg;
  int? systemTime;

  BaseHttpResponse();

  //反序列化
  factory BaseHttpResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseHttpResponseFromJson(json);

//序列化
  Map<String, dynamic> toJson() => _$BaseHttpResponseToJson(this);
}

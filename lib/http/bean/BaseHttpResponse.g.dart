// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseHttpResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseHttpResponse _$BaseHttpResponseFromJson(Map<String, dynamic> json) {
  return BaseHttpResponse()
    ..code = json['code'] as int
    ..data = json['data'] as String?
    ..msg = json['msg'] as String?
    ..systemTime = json['systemTime'] as int?;
}

Map<String, dynamic> _$BaseHttpResponseToJson(BaseHttpResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'systemTime': instance.systemTime,
    };

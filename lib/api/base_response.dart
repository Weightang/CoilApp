




import 'package:flutter_app/common/Constants.dart';

/// 子类需要重写
abstract class BaseResponseData {
  int code;
  String message;
  dynamic data;

  bool get success;

  BaseResponseData({this.code, this.message,this.data});

  @override
  String toString() {
    return 'BaseRespData{code: $code, message: $message, data: $data}';
  }
}

class ResponseData extends BaseResponseData {
  bool get success => Constants.SUCCESS == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['state'];
    message = json['msg'];
    data = json['data'];
  }
}
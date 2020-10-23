import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_app/common/Constants.dart';



class HeaderInterceptor extends Interceptor {
  HeaderInterceptor();

  //请求之前
  @override
  Future onRequest(RequestOptions options) {
    options.headers["token"] = Constants.token;
    return super.onRequest(options);
  }

  // 返回
  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }

  // 错误
  @override
  Future onError(DioError err) {
    return super.onError(err);
  }
}

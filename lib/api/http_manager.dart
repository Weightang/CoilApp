export 'package:dio/dio.dart';

// 必须是顶层函数
import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

import 'package:dio/native_imp.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/common/Constants.dart';
import 'package:flutter_app/config/storage_manager.dart';
import 'package:flutter_app/utils/platform_utils.dart';



import 'api.dart';
import 'base_response.dart';
import 'header_Interceptor.dart';
import 'http_error.dart';
import 'log_interceptor.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    /// 初始化 加入app通用处理
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors..add(HeaderInterceptor());
    init();
  }

  void init();
}

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = Api.BASE_URL;
    interceptors
      ..add(IFMInterceptor())
      ..add(MyLogInterceptor(
          requestBody: !inProduction, responseBody: !inProduction))
      // cookie持久化 异步
      ..add(CookieManager(
          PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
  }
}

///
class IFMInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
//    debugPrint('---api-response--->resp----->${response.data}');
    ResponseData respData = ResponseData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      return http.resolve(response);
    } else {
      if (respData.code == Constants.ERROR_TOKEN_EXPIRED) {
        // 如果cookie过期,需要清除本地存储的登录信息
        // StorageManager.localStorage.deleteItem(UserModel.keyUser);
        throw const UnAuthorizedException(); // 需要登录
      } else {
        throw NotSuccessException.fromRespData(respData);
      }
    }
  }
}

import 'package:dio/dio.dart';

import 'injection.dart';
import 'local_storage.dart';

class DioHelper {
  Dio dio = getDio();

  Future<Map<String, dynamic>> _getHeaders(bool isAuthRequired) async {
    final storage = LocalStorage();
    final token = storage.getToken();
    print( "------>${token}");
    if (isAuthRequired && token != null) {
      return {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
    } else {
      return {
        'Content-Type': 'application/json',
      };
    }
  }

  Future<Options> options(bool isAuthRequired) async {
    final headers = await _getHeaders(isAuthRequired);
    return Options(
      receiveDataWhenStatusError: true,
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      headers: headers,
    );
  }

  /// GET API
  Future<dynamic> get({required String url, bool isAuthRequired = false}) async {
    try {
      Response response = await dio.get(url, options: await options(isAuthRequired));
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// POST API
  Future<dynamic> post({required String url, Object? requestBody, bool isAuthRequired = false}) async {
    try {
      Response response;
      if (requestBody == null) {
        response = await dio.post(url, options: await options(isAuthRequired));
      } else {
        response = await dio.post(url, data: requestBody, options: await options(isAuthRequired));
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// PUT API
  Future<dynamic> put({required String url, Object? requestBody, bool isAuthRequired = false}) async {
    try {
      Response response;
      if (requestBody == null) {
        response = await dio.put(url, options: await options(isAuthRequired));
      } else {
        response = await dio.put(url, data: requestBody, options: await options(isAuthRequired));
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// PATCH API
  Future<dynamic> patch({required String url, Object? requestBody, bool isAuthRequired = false}) async {
    try {
      Response response;
      if (requestBody == null) {
        response = await dio.patch(url, options: await options(isAuthRequired));
      } else {
        response = await dio.patch(url, data: requestBody, options: await options(isAuthRequired));
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// DELETE API
  Future<dynamic> delete({required String url, Object? requestBody, bool isAuthRequired = false}) async {
    try {
      Response response;
      if (requestBody == null) {
        response = await dio.delete(url, options: await options(isAuthRequired));
      } else {
        response = await dio.delete(url, data: requestBody, options: await options(isAuthRequired));
      }
      return response.data;
    } catch (error) {
      return null;
    }
  }

  /// MULTIPART API
  Future<dynamic> uploadFile({required String url, required var requestBody, bool isAuthRequired = true}) async {
    try {
      Response response = await dio.post(url, data: requestBody,);
      return response.data;
    } catch (error) {
      return null;
    }
  }
}



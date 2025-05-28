import 'package:dio/dio.dart';
import 'api_consumer.dart';
import 'api_interceptors.dart';
import 'endpoints.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        error: true,
        responseBody: true,
        responseHeader: true));
  }

  @override
  Future delete(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFromDara = false}) async {
    var response = await dio.delete(path,
        data: isFromDara ? FormData.fromMap(data) : data,
        queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    var response =
        await dio.get(path, data: data, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFromDara = false}) async {
    var response = await dio.patch(path,
        data: isFromDara ? FormData.fromMap(data) : data,
        queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFromDara = false}) async {
    var response = await dio.post(path,
        data: isFromDara ? FormData.fromMap(data) : data,
        queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future put(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFromDara = false}) async {
    var response = await dio.put(path,
        data: isFromDara ? FormData.fromMap(data) : data,
        queryParameters: queryParameters);
    return response.data;
  }
}

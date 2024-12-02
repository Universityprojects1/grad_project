import 'package:dio/dio.dart';



import 'end_points.dart';


class APiManger {
  final Dio dio = Dio();

  APiManger();

  Future<Response> get(String endPoint, {Map<String, dynamic>? body}) {
    return dio.get(EndPoints.baseUrl + endPoint, data: body);
  }

  Future<Response> post(String endPoint, dynamic body) {
    return dio.post(EndPoints.baseUrl + endPoint, data: body,  );
  }
}

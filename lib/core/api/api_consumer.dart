//dio: ^5.6.0

abstract class ApiConsumer {
 Future<dynamic> get(String path, {Object? data, Map<String, dynamic>? queryParameters});

 Future<dynamic> put(String path, {Object? data, Map<String, dynamic>? queryParameters,bool isFromDara = false});

 Future<dynamic> patch(String path, {Object? data, Map<String, dynamic>? queryParameters,bool isFromDara = false});

 Future<dynamic> post(String path, {Object? data, Map<String, dynamic>? queryParameters,bool isFromDara = false});

 Future<dynamic> delete(String path, {Object? data, Map<String, dynamic>? queryParameters,bool isFromDara = false});
}

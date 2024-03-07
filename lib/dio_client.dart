import 'package:dio/dio.dart';

class DioClient {
  final String apiBaseUrl;

  const DioClient({required this.apiBaseUrl});

  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: _getHeaders(),
    );
    Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor());

    return dio;
  }

  Map<String, dynamic> _getHeaders() {
    return {
      "accept": "application/json",
    };
  }
}

import 'package:dio/dio.dart';
import 'package:tmdb_flutter/dio_client.dart';
import 'package:tmdb_flutter/movies_model.dart';

class ApiRepository {
  final _dio = const DioClient(apiBaseUrl: "https://api.themoviedb.org/3/").dio;

  Future<MoviesModel> fetchMovieList() async {
    try {
      Response response = await _dio.get("movie/popular", queryParameters: _getQueryParameters());
      return MoviesModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MoviesModel.withError("Data not found / Connection issue");
    }
  }

  Map<String, dynamic> _getQueryParameters() {
    return {
      "api_key": "69024b5fd7021af153433363208b4636",
      "language": "en-US",
      "page": "1",
    };
  }
}
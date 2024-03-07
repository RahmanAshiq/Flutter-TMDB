import 'movie_model.dart';

class MoviesModel {
  int? page;
  int? totalPages;
  int? totalResults;
  List<MovieModel>? results;
  String? error;

  MoviesModel({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  MoviesModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    if (json['results'] != null) {
      results = <MovieModel>[];
      json['results'].forEach((v) {
        results!.add(MovieModel.fromJson(v));
      });
    }
  }

  MoviesModel.withError(String errorMessage) {
    error = errorMessage;
  }
}
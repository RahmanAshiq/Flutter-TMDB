class MovieModel {
  int? id;
  int? voteCount;
  num? voteAverage;
  String? title;
  String? overview;
  num? popularity;
  String? posterPath;
  String? releaseDate;
  String? originalTitle;

  MovieModel({
    this.id,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.originalTitle,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'];
    title = json['title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    originalTitle = json['original_title'];
  }
}
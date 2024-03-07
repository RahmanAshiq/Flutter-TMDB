part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final MoviesModel moviesModel;
  const MovieLoaded(this.moviesModel);
}

class MovieError extends MovieState {
  final String? message;
  const MovieError(this.message);
}
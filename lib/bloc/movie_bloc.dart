import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_flutter/app.dart';
import 'package:tmdb_flutter/movies_model.dart';

import '../api_repository.dart';
import '../network_error.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final ApiRepository apiRepository;
  MovieBloc(this.apiRepository) : super(MovieInitial()) {

    on<GetMovieList>((event, emit) async {
      try {
        emit(MovieLoading());
        final mList = await apiRepository.fetchMovieList();
        emit(MovieLoaded(mList));
        if (mList.error != null) {
          emit(MovieError(mList.error));
        }
      } on NetworkError {
        emit(MovieError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
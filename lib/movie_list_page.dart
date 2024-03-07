import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_flutter/api_repository.dart';
import 'package:tmdb_flutter/movie_detail_page.dart';

import 'app.dart';
import 'bloc/movie_bloc.dart';
import 'movies_model.dart';
import 'movie_model.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late final MovieBloc _moviesBloc;

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ApiRepository apiRepository = MovieInheritedWidget.of(context).apiRepository;
    _moviesBloc = MovieBloc(apiRepository);
    _moviesBloc.add(GetMovieList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies List')),
      body: _buildListMovie(),
    );
  }

  Widget _buildListMovie() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _moviesBloc,
        child: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieInitial) {
                return const CircularLoading();
              } else if (state is MovieLoading) {
                return const CircularLoading();
              } else if (state is MovieLoaded) {
                return MovieList(state.moviesModel);
              } else if (state is MovieError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

}

class MovieList extends StatelessWidget {
  final MoviesModel moviesModel;
  const MovieList(this.moviesModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: moviesModel.results!.length ?? 0,
      itemBuilder: (context, index) {
        return MovieCard(moviesModel.results![index]);
      },
    );
  }
}


class MovieCard extends StatelessWidget {
  final MovieModel movieModel;
  const MovieCard(this.movieModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 50, sigmaX: 50),
                  child: Image.network("https://image.tmdb.org/t/p/w500${movieModel.posterPath}"),
                ),
                // child: Image.network("https://image.tmdb.org/t/p/w500${model.results![index].posterPath}"),
                // child: CachedNetworkImage(
                //   imageUrl: "https://image.tmdb.org/t/p/w500${model.results![index].posterPath}",
                //   height: 130.0,
                //   width: 100.0,
                //   fit: BoxFit.cover,
                //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                //       Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                //   errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                // ),
              ),
              InkWell(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Text("Title: ${movieModel.title}"),
                      Text("Vote Count: ${movieModel.voteCount}"),
                      Text("Vote Average: ${movieModel.voteAverage}"),
                      Text("Popularity: ${movieModel.popularity}"),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(movieModel),
                    ),
                  );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text("I am tapped ${movieModel.title}"),
                  //     )
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

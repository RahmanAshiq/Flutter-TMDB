import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tmdb_flutter/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movieModel;
  const MovieDetailPage(this.movieModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${movieModel.title}")),
      body: Container(
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
            Text("Title: ${movieModel.title}"),
            Text("Vote Count: ${movieModel.voteCount}"),
            Text("Vote Average: ${movieModel.voteAverage}"),
            Text("Popularity: ${movieModel.popularity}"),
          ],
        ),
      ),
    );
  }
}

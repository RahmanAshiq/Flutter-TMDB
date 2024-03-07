import 'package:flutter/material.dart';
import 'package:tmdb_flutter/api_repository.dart';
import 'package:tmdb_flutter/movie_list_page.dart';

import 'home_page.dart';

class MainApp extends StatelessWidget {
  final ApiRepository apiRepository = ApiRepository();
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const HomePage(title: 'Flutter Demo Home Page'),
      home: MovieInheritedWidget(
        apiRepository: apiRepository,
        child: MoviePage(),
      ),
    );
  }
}

class MovieInheritedWidget extends InheritedWidget {
  const MovieInheritedWidget({
    super.key,
    required super.child,
    required this.apiRepository,
  });

  final ApiRepository apiRepository;

  static MovieInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MovieInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(MovieInheritedWidget oldWidget) {
    return oldWidget.apiRepository != apiRepository;
  }
}

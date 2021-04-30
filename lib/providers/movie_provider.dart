import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/movie_model.dart';
import 'package:flutter_test_app/repositories/movie_repository.dart';

class MovieProvider extends ChangeNotifier {
  //create an instance of movieRepository
  MovieRepository movieRepository = MovieRepository();

  List<Movie> movies = [];

  UnmodifiableListView<Movie> get someMovies => UnmodifiableListView(movies);

  MovieProvider() {
    //fetch all movies if the personal bool is false else fetch on movies purchased by the current user

    fetchAllMovies();
    // } else {
    //   fetchMyMovies();
    // }
  }

  void fetchAllMovies() async {
    movies = await movieRepository.getMovies();

    notifyListeners();
  }

  Future<String> purchaseMovie(Movie movie) async {
    var res = await movieRepository.purchaseMovie(movie);
  }

  Future<String> addMovie(Movie movie) async {
    //add new movie
    return movieRepository.addMovie(movie);
  }

  void queryMovies(String query) async {
    // check if query isn empty string, in that case select only movies that matches the query and return
    // else return new set of movies from the backend
    if (query != '') {
      movies = movies.where(
        (element) =>
            element.title.contains(query) ||
            element.genre == query ||
            element.starring.contains(query),
      );
    } else {
      //fetch another set of movies
      fetchAllMovies();
    }

    //notify listeners
    notifyListeners();
  }

  void fetchMyMovies() async {
    movies = await movieRepository.getMyMovies();
  }
}

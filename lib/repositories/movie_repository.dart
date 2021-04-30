import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test_app/helper/constants.dart';
import 'package:flutter_test_app/models/movie_model.dart';

class MovieRepository {
  static final MovieRepository _instance = MovieRepository._internal();

  factory MovieRepository() {
    return _instance;
  }

  MovieRepository._internal();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future getMovies() async {
    //return a stream of list<Movie> for UI consumption
    List<Movie> movies = [];
    QuerySnapshot movieSnapshot =
        await firebaseFirestore.collection(MOVIECOLLECTION).limit(100).get();

    for (var movie in movieSnapshot.docs) {
      movies.add(
        Movie.fromMap(
          movie.data(),
        ),
      );
    }

    return movies;
  }

  Future getMyMovies() async {
    //return a stream of list<Movie> for UI consumption
    List<Movie> movies = [];
    String email = FirebaseAuth.instance.currentUser.email;
    QuerySnapshot movieSnapshot =
        await firebaseFirestore.collection(email).limit(100).get();

    for (var movie in movieSnapshot.docs) {
      movies.add(
        Movie.fromMap(
          movie.data(),
        ),
      );
    }

    return movies;
  }

  Future<String> purchaseMovie(Movie movie) async {
    String email = FirebaseAuth.instance.currentUser.email;
    try {
      await firebaseFirestore.collection(email).doc().set(movie.toMap());
      return 'success';
    } catch (e) {
      return null;
    }
  }

  Future<String> addMovie(Movie movie) async {
    try {
      await firebaseFirestore.collection(MOVIECOLLECTION).doc().set(
            movie.toMap(),
          );
      return 'success';
    } catch (e) {
      return e.message;
    }
  }

  Future<List<Movie>> queryMovies(String query) async {
    List<Movie> movies = [];
    //get 100 movies from the backend
    QuerySnapshot moviesSnapshots = await firebaseFirestore
        .collection(MOVIECOLLECTION)
        .where('title', isEqualTo: query)
        .limit(100)
        .get();

    //loop through the snapshots, create a movie from each snapshot and add to the movies list
    for (var movieSnapshot in moviesSnapshots.docs) {
      Movie movie = Movie.fromMap(movieSnapshot.data());
      movies.add(movie);
    }

    //return the movies
    return movies;
  }
}

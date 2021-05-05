import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test_app/helper/constants.dart';
import 'package:flutter_test_app/models/movie_model.dart';

class MovieRepository {
  static final MovieRepository _instance = MovieRepository._internal();

  factory MovieRepository() {
    return _instance;
  }

  MovieRepository._internal();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Movie>> getMoviesStream() {
    Stream<QuerySnapshot> movieSnapshot =
        firebaseFirestore.collection(MOVIECOLLECTION).limit(100).snapshots();

    return movieSnapshot.map((event) {
      return event.docs.map((e) {
        return Movie.fromMap(e.data());
      }).toList();
    });
  }

  Stream<List<Movie>> getMyMovies() {
    String email = FirebaseAuth.instance.currentUser.email;
    Stream<QuerySnapshot> movieSnapshot =
        firebaseFirestore.collection(email).limit(100).snapshots();

    return movieSnapshot.map((event) {
      return event.docs.map((e) {
        return Movie.fromMap(e.data());
      }).toList();
    });
  }

  Future<String> purchaseMovie(Movie movie) async {
    String email = FirebaseAuth.instance.currentUser.email;
    try {
      await firebaseFirestore.collection(email).doc().set(movie.toMap());
      await firebaseFirestore
          .collection('history')
          .doc()
          .set({'history': "$email purchased ${movie.title}"});
      return 'success';
    } catch (e) {
      return null;
    }
  }

  Stream<List<String>> getHistory() {
    Stream<QuerySnapshot> movieSnapshot =
        firebaseFirestore.collection('history').limit(100).snapshots();

    return movieSnapshot.map((event) {
      return event.docs.map((e) {
        return e.data()['history'];
      }).toList();
    });
  }

  Future<String> addMovie(Movie movie) async {
    try {
      String imageUri = '';
      String videoUri = '';
      if (movie.imageUri != null) {
        TaskSnapshot uploadTask = await FirebaseStorage.instance
            .ref('movieImages')
            .putFile(File(movie.imageUri));

        imageUri = await uploadTask.ref.getDownloadURL();
      }
      if (movie.videoUri != null) {
        TaskSnapshot uploadTask = await FirebaseStorage.instance
            .ref('videoFiles')
            .putFile(File(movie.videoUri));

        videoUri = await uploadTask.ref.getDownloadURL();
      }

      movie.imageUri = imageUri;
      movie.videoUri = videoUri;

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

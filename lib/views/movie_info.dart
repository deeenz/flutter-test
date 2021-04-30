import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/movie_model.dart';

class MovieInfo extends StatefulWidget {
  final Movie movie;

  MovieInfo(this.movie);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MovieInfoState();
  }
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

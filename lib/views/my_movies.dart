import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/movie_model.dart';
import 'package:flutter_test_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MyMoviesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyMoviesPageState();
  }
}

class _MyMoviesPageState extends State<MyMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Movies'),
      ),
      body: StreamBuilder<List<Movie>>(
        stream: Provider.of<MovieProvider>(context).fetchMyMovies(),
        builder: (context, movie) {
          return (movie.data == null || movie.data.length ==0)
              ? Center(
                  child:
                      Text("You haven't purchased any movies yet, please do."),
                )
              : ListView.builder(
                  itemCount: movie.data.length,
                  itemBuilder: (context, index) {
                    return movieItem(movie.data[index]);
                  });
        },
      ),
    );
  }

  Widget movieItem(Movie movie) {
    return GestureDetector(
      child: ListTile(
        title: Text(
          movie.title.toUpperCase(),
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle:
            Text("${movie.genre.toUpperCase()} starring ${movie.starring}"),
      ),
    );
  }
}

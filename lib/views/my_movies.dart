import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/helper/constants.dart';
import 'package:flutter_test_app/models/movie_model.dart';
import 'package:provider/provider.dart';

class MyMoviesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyMoviesPageState();
  }
}

class _MyMoviesPageState extends State<MyMoviesPage> {
  final Stream<Movie> movies = (() async* {
    String email = FirebaseAuth.instance.currentUser.email;
    Movie m;
    FirebaseFirestore.instance.collection(email).snapshots().map((event) => {
          event.docs.map((e) {
            m = Movie.fromMap(e.data());
          })
        });
    yield m;
  })();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Movies'),
      ),
      body: StreamBuilder(
        stream: movies,
        builder: (context, movie) {
          return Container();
        },
      ),
    );
  }

  Widget movieItem(Movie movie) {}

  Widget _buildSearchTextField() {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColorLight,
      ),
      child: TextField(
        onChanged: (value) {},
        cursorColor: Color(0XF757575),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          fillColor: Theme.of(context).primaryColorLight,
          labelText: "Search",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.0, color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
        ),
      ),
    );
  }
}

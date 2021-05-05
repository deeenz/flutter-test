import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/movie_model.dart';
import 'package:flutter_test_app/views/videoPlayer.dart';
import 'package:video_player/video_player.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title.toUpperCase()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VideoApp(widget.movie),
            ),
          );
        },
      ),
      body: Container(
        width: screenWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.movie.imageUri), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 10),
              child: Text(
                "Description: ${widget.movie.description}",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    backgroundColor: Theme.of(context).accentColor),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                "Starring: ${widget.movie.starring}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    backgroundColor: Theme.of(context).accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

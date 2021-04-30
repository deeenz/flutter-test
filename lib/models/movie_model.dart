import 'package:flutter/material.dart';

class Movie {
  String title;
  String id;
  String description;
  String imageUri;
  String videoUri;
  String genre;
  String starring;

  Movie(
      {@required this.title,
      @required this.description,
      this.imageUri,
      this.videoUri,
      this.genre,
      @required this.id,
      this.starring});

  // declare a helper method to help convert movie object to map for storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'starring': starring,
      'genre': genre,
      'description': description,
      'imageUri': imageUri,
      'videoUri': videoUri,
    };
  }

  //declaration of a method that helps convert a map to a Movie object
  Movie.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        imageUri = map['imageUri'],
        videoUri = map['videoUri'],
        genre = map['genre'],
        starring = map['starring'];
}

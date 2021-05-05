import 'package:flutter/material.dart';
import 'package:flutter_test_app/repositories/movie_repository.dart';

class HistoryProvider extends ChangeNotifier {
  MovieRepository repo = MovieRepository();
  
  Stream<List<String>> getHistory() {
    return repo.getHistory();
  }
}

import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/repositories/auth_repository.dart';


class AuthProvider extends ChangeNotifier {
  //create an instance of movieRepository
  AuthRepository authRepository = AuthRepository();

  Future<User> login(String email, String password) async {
    return authRepository.login(email, password);
  }

  Future<String> register(String email, String password, String name) async {
    return authRepository.register(email, password, name);
  }

  User getCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser;
  }

  // void queryMovies(String query) async {
  //   movies = await movieRepository.queryMovies(query);

  //   //notify listeners
  //   notifyListeners();
  // }
}

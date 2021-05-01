import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/views/add_movie.dart';
import 'package:flutter_test_app/views/all_movies.dart';
import 'package:flutter_test_app/views/history.dart';
import 'package:flutter_test_app/views/my_movies.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage(this.user);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String title = 'Sales';

  List<BottomNavigationBarItem> userNavItems = [
    BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label: 'My Movies',
      icon: Icon(Icons.movie),
    ),
  ];

  List<BottomNavigationBarItem> adminNavItems = [
    BottomNavigationBarItem(
      label: 'Add Movie',
      icon: Icon(Icons.movie_creation_outlined, size: 30),
    ),
    BottomNavigationBarItem(
      label: 'History',
      icon: Icon(Icons.widgets),
    ),
  ];

  List<Widget> userNAvWidgets = [
    AllMovies(),
    MyMoviesPage(),
  ];

  List<Widget> adminNavWidgets = [
    AddMovie(),
    HistoryPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).accentColor,
        items: (widget.user.email.contains('admin'))
            ? adminNavItems
            : userNavItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        children: (widget.user.email.contains('admin'))
            ? adminNavWidgets
            : userNAvWidgets,
        index: _selectedIndex,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

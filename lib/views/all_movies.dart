import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anywhere_menus/flutter_anywhere_menus.dart';
import 'package:flutter_test_app/models/movie_model.dart';
import 'package:flutter_test_app/providers/movie_provider.dart';
import 'package:flutter_test_app/views/login_page.dart';
import 'package:flutter_test_app/views/movie_info.dart';
import 'package:provider/provider.dart';

class AllMovies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AllMoviesState();
  }
}

class _AllMoviesState extends State<AllMovies> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchTextField(),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              showMenu(
                  context: context,
                  items: [
                    PopupMenuItem(
                      child: GestureDetector(
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          title: Text("Logout"),
                        ),
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((value) => {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                )
                              });
                        },
                      ),
                    ),
                  ],
                  position: RelativeRect.fromLTRB(screenWidth * .7, 0, 0, 0));
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Consumer<MovieProvider>(
          builder: (context, movie, child) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemCount: movie.someMovies.length,
            itemBuilder: (context, index) {
              return movieItem(movie.someMovies[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget movieItem(Movie movie) {
    Menu(
      menuBar: MenuBar(
          drawArrow: true,
          drawDivider: true,
          itemPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          menuItems: [
            MenuItem(
              child: Text("View"),
              onTap: () {
                // goto edit dialog
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MovieInfo(movie),
                  ),
                );
              },
            ),
            MenuItem(
              child: Text("Purchase (\$0)"),
              onTap: () async {
                // goto edit dialog
                var res = await Provider.of<MovieProvider>(context)
                    .purchaseMovie(movie);
                if (res == 'success') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Movie Successfully Purchase"),
                    ),
                  );
                }
              },
            ),
          ]),
      child: Card(
        elevation: 3,
        child: Column(
          children: [Text(movie.title)],
        ),
      ),
    );
  }

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

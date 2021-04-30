import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/movie_model.dart';
import 'package:flutter_test_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class AddMovie extends StatefulWidget {
  AddMovie({Key key}) : super(key: key);

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  GlobalKey<FormState> addMovieFormKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController starringController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedGenre;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Movie'),
        centerTitle: true,
      ),
      body: Form(
        key: addMovieFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 60,
                width: screenWidth * .7,
                child: TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Movie Title';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Enter Movie Title',
                    prefixIcon: Icon(Icons.title),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor, width: 5),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 60,
              width: screenWidth * .7,
              child: TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Movie Description';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter Movie Description',
                  prefixIcon: Icon(Icons.description),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor, width: 5),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 60,
              width: screenWidth * .7,
              child: TextFormField(
                controller: starringController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Movie Stars';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter Movie Stars',
                  prefixIcon: Icon(Icons.star),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor, width: 5),
                  ),
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.7,
              height: 60,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                value: selectedGenre,
                items: <DropdownMenuItem>[
                  DropdownMenuItem(
                    child: Text('Action'),
                    value: 'Actions',
                  ),
                  DropdownMenuItem(
                    child: Text('Adventure'),
                    value: 'Adventure',
                  ),
                  DropdownMenuItem(
                    child: Text('Comedy'),
                    value: 'Comedy',
                  ),
                  DropdownMenuItem(
                    child: Text('Crime and mystery'),
                    value: 'Crime and mystery',
                  ),
                  DropdownMenuItem(
                    child: Text('Fantasy'),
                    value: 'Fantasy',
                  ),
                  DropdownMenuItem(
                    child: Text('Historical'),
                    value: 'Historical',
                  ),
                  DropdownMenuItem(
                    child: Text('Horror'),
                    value: 'Horror',
                  ),
                  DropdownMenuItem(
                    child: Text('Romance'),
                    value: 'Romance',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value;
                  });
                },
                hint: Text("Select Movie Genre"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (addMovieFormKey.currentState.validate()) {
                    // call the the auth controller for authentication
                    String email = FirebaseAuth.instance.currentUser.email;
                    Movie movie = Movie(
                        description: descriptionController.text,
                        title: titleController.text,
                        imageUri: '',
                        videoUri: '',
                        genre: selectedGenre,
                        starring: starringController.text,
                        id: '');

                    Provider.of<MovieProvider>(context, listen: false)
                        .addMovie(movie)
                        .then(
                          (value) => {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Movie Added"),
                              ),
                            )
                          },
                        );
                  }
                },
                child: Text(
                  "Add Movie",
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor)),
              ),
              height: 60,
              width: screenWidth * .7,
            ),
          ],
        ),
      ),
    );
  }
}

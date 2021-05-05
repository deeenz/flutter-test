import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/movie_model.dart';
import 'package:flutter_test_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import 'login_page.dart';

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
  String selectedImagePath;
  String selectedVideoPath;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Movie'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert_outlined,
              color: Colors.white,
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
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 60,
                width: screenWidth * .7,
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * .3,
                      child: ElevatedButton(
                        onPressed: () async {
                          FilePickerResult result = await FilePicker.platform
                              .pickFiles(type: FileType.image);

                          if (result != null) {
                            selectedImagePath = result.files.single.path;
                          } else {
                            // User canceled the picker
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please select a cover picture"),
                              ),
                            );
                          }
                        },
                        child: Text("Cover Image"),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * .1,
                    ),
                    Container(
                      width: screenWidth * .3,
                      child: ElevatedButton(
                        onPressed: () async {
                          FilePickerResult result = await FilePicker.platform
                              .pickFiles(type: FileType.video);

                          if (result != null) {
                            selectedVideoPath = result.files.single.path;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please select a video file"),
                              ),
                            );
                          }
                        },
                        child: Text("Video File"),
                      ),
                    ),
                  ],
                )),
            (loading)
                ? Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                      height: 60,
                      width: 60,
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (addMovieFormKey.currentState.validate()) {
                          if (selectedGenre == null ||
                              selectedImagePath == null ||
                              selectedVideoPath == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Please ensure that you have selected the movie genre, uploaded the cover image and video file"),
                              ),
                            );
                          } else {
                            setState(() {
                              loading = true;
                            });
                            //create a movie instance from the information proivided
                            Movie movie = Movie(
                                description: descriptionController.text,
                                title: titleController.text,
                                imageUri: selectedImagePath,
                                videoUri: selectedVideoPath,
                                genre: selectedGenre,
                                starring: starringController.text,
                                id: '');
                            // call the movie provider to do the movie storing
                            Provider.of<MovieProvider>(context, listen: false)
                                .addMovie(movie)
                                .then(
                              (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Movie Added"),
                                  ),
                                );
                                setState(() {
                                  loading = false;
                                });
                              },
                            );
                          }
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

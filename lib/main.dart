import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/providers/auth_provider.dart';
import 'package:flutter_test_app/providers/historyProvider.dart';
import 'package:flutter_test_app/providers/movie_provider.dart';
import 'package:flutter_test_app/views/home_page.dart';
import 'package:flutter_test_app/views/login_page.dart';
import 'package:flutter_test_app/views/register_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) {
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider<MovieProvider>(
          create: (_) {
            return MovieProvider();
          },
        ),
        ChangeNotifierProvider<HistoryProvider>(
          create: (_) {
            return HistoryProvider();
          },
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
      home: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (auth.getCurrentUser() == null) {
            return LoginPage();
          }
          return HomePage(auth.getCurrentUser());
        },
      ),
    );
  }
}

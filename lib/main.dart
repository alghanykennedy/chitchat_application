import 'package:chitchat_application/Screens/Welcome/welcome_screen.dart';
import 'package:chitchat_application/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChitChat Application',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return WelcomeScreen();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return WelcomeScreen();
          }

          return WelcomeScreen();
        },
      ),
    );
  }
}

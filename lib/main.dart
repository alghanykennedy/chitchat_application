import 'package:chitchat_application/Screens/Chats/chats_screen.dart';
import 'package:chitchat_application/Screens/Signup/signup_screen.dart';
import 'package:chitchat_application/Screens/Welcome/welcome_screen.dart';
import 'package:chitchat_application/constants.dart';
import 'package:chitchat_application/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/Login/login_screen.dart';
import 'observer/bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Observer();
  runApp(
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(FirebaseAuth.instance),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChitChat Application',
      routes: {
        "/": (context) => WelcomeScreen(),
        "/login": (context) => LoginScreen(),
        "/signup": (context) => SignUpScreen(),
        "/home": (context) => ChatScreen(),
      },
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: FutureBuilder(
      //   future: _initialization,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return WelcomeScreen();
      //     }

      //     // Once complete, show your application
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return WelcomeScreen();
      //     }

      //     return WelcomeScreen();
      //   },
      // ),
    );
  }
}

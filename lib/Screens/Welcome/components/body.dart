import 'package:chitchat_application/Screens/Login/login_screen.dart';
import 'package:chitchat_application/Screens/Signup/signup_screen.dart';
import 'package:chitchat_application/Screens/Welcome/components/background.dart';
import 'package:chitchat_application/components/rounded_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'WELCOME TO CHITCHAT',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              'assets/icons/chat.svg',
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              style: raisedButtonStyle,
              press: () {
                Navigator.pushNamed(context, '/login');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return LoginScreen();
                //     },
                //   ),
                // );
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              style: secondButtonStyle,
              press: () {
                Navigator.pushNamed(context, "/signup");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return SignUpScreen();
                //     },
                //   ),
                // );
              },
            )
          ],
        ),
      ),
    );
  }
}

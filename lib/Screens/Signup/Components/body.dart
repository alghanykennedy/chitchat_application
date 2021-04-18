import 'package:chitchat_application/Screens/Chats/welcome_to_chat_screen.dart';
import 'package:chitchat_application/Screens/Login/login_screen.dart';
import 'package:chitchat_application/Screens/Signup/Components/background.dart';
import 'package:chitchat_application/Screens/Signup/Components/or_divider.dart';
import 'package:chitchat_application/Screens/Signup/Components/social_icons.dart';
import 'package:chitchat_application/components/already_have_an_account_check.dart';
import 'package:chitchat_application/components/rounded_button.dart';
import 'package:chitchat_application/components/rounded_input_field.dart';
import 'package:chitchat_application/components/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'SIGNUP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.015),
            SvgPicture.asset(
              'assets/icons/signup.svg',
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: 'Your Email',
              onChanged: (value) {
                _emailController.text = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _passwordController.text = value;
              },
            ),
            RoundedButton(
              text: 'SIGNUP',
              style: raisedButtonStyle,
              press: () async {
                try {
                  // print(_emailController.text);
                  final register =
                      await _firebaseAuth.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  final db =
                      FirebaseDatabase().reference().child('user').push().set({
                    "email": _emailController.text,
                    "passwor": _passwordController.text,
                  });
                  print(db);
                  // print(register);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WelcomeChatScreen(),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[700],
                      content: Text(
                        e.message ?? e.toString(),
                      ),
                    ),
                  );
                } catch (e) {
                  print("error $e");
                }
              },
            ),
            SizedBox(height: size.height * 0.02),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: 'assets/icons/facebook.svg',
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: 'assets/icons/twitter.svg',
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: 'assets/icons/google-plus.svg',
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

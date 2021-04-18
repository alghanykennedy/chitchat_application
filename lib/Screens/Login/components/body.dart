import 'package:chitchat_application/Screens/Chats/chats_screen.dart';
import 'package:chitchat_application/Screens/Login/components/background.dart';
import 'package:chitchat_application/Screens/Signup/signup_screen.dart';
import 'package:chitchat_application/components/already_have_an_account_check.dart';
import 'package:chitchat_application/components/rounded_button.dart';
import 'package:chitchat_application/components/rounded_input_field.dart';
import 'package:chitchat_application/components/rounded_password_field.dart';
import 'package:chitchat_application/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

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
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'LOGIN',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              'assets/icons/login.svg',
              height: size.height * 0.32,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedInputField(
              hintText: 'Email',
              onChanged: (value) {
                _emailController.text = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _passwordController.text = value;
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLogin) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                } else if (state is AuthLoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[700],
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: RoundedButton(
                  text: 'LOGIN',
                  style: raisedButtonStyle,
                  press: () {
                    context.read<AuthCubit>().onLogin(
                        _emailController.text, _passwordController.text);
                  }),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushNamed(context, "/signup");
              },
            )
          ],
        ),
      ),
    );
  }
}

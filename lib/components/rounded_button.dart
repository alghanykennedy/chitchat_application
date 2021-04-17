import 'package:chitchat_application/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final ButtonStyle style;
  final Function press;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 45,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        child: Text(text),
        style: style,
        onPressed: press,
      ),
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: kPrimaryLightColor,
    primary: kPrimaryColor,
    minimumSize: Size(230, 20),
    padding: EdgeInsets.symmetric(horizontal: 20),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(29)),
    ));

final ButtonStyle secondButtonStyle = ElevatedButton.styleFrom(
    onPrimary: kPrimaryColor,
    primary: Colors.purple[50],
    minimumSize: Size(230, 20),
    padding: EdgeInsets.symmetric(horizontal: 20),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(29)),
    ));

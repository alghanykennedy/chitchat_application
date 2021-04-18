import 'package:chitchat_application/Screens/Chats/components/welcomebody.dart';
import 'package:chitchat_application/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WelcomeChatScreen extends StatefulWidget {
  @override
  _WelcomeChatScreenState createState() => _WelcomeChatScreenState();
}

class _WelcomeChatScreenState extends State<WelcomeChatScreen> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: WelcomeBodyChat(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final db =
              FirebaseDatabase().reference().child('chat_rooms').push().set({
            "user1": "alghany@gmail.com",
            "user2": "sanbersy@gmail.com",
          });
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add_comment_rounded),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded), label: "Profile"),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Chats'),
      elevation: 0.0,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}

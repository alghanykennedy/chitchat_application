import 'dart:ui';
import 'package:chitchat_application/Screens/Chats/components/chat_card.dart';
import 'package:chitchat_application/Screens/Messages/messages_screen.dart';
import 'package:chitchat_application/Screens/Welcome/welcome_screen.dart';
import 'package:chitchat_application/components/filled_outlline_button.dart';
import 'package:chitchat_application/constants.dart';
import 'package:chitchat_application/models/chat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WelcomeBodyChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: 'Recent Message'),
              SizedBox(width: 8),
              FillOutlineButton(
                press: () {},
                text: 'Active',
                isFilled: false,
              ),
              SizedBox(width: 8),
              FillOutlineButton(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WelcomeScreen();
                      },
                    ),
                  );
                },
                text: 'Logout',
                isFilled: false,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 180),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: 'WELCOME TO CHITCHAT \n',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor),
                ),
                TextSpan(
                  text:
                      'Click Add Message Icon Button to Start ChitChat Message',
                ),
              ],
            ),
          ),
        ),
        // Expanded(
        //   child: StreamBuilder(
        //       stream: FirebaseDatabase.instance
        //           .reference()
        //           .child('chat_rooms')
        //           .onValue,
        //       builder: (context, snap) {
        //         if (snap.hasData && !snap.hasError) {
        //           Map data = snap.data.snapshot.value;
        //           print(data.keys);
        //           List item = [];
        //           data.keys.forEach((key) {
        //             String name;
        //             if (data[key]["user1"] == "alghany@gmail.com") {
        //               name = "sanbersy@gmail.com";
        //             } else {
        //               name = "alghany@gmail.com";
        //             }
        //             item.add(
        //               Chat(
        //                   name: name,
        //                   image: null,
        //                   isActive: false,
        //                   lastMessage: "Glad you like it",
        //                   time: "18.23"),
        //             );
        //           });
        //           print(item);

        //           return ListView.builder(
        //             itemCount: item.length,
        //             itemBuilder: (context, index) => ChatCard(
        //               chat: item[index],
        //               press: () => Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => MessagesScreen(),
        //                 ),
        //               ),
        //             ),
        //           );
        //         }
        //         return ListView.builder(
        //           itemCount: chatsData.length,
        //           itemBuilder: (context, index) => ChatCard(
        //             chat: chatsData[index],
        //             press: () => Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => MessagesScreen(),
        //               ),
        //             ),
        //           ),
        //         );
        //       }),
        // ),
      ],
    );
  }
}

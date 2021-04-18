import 'package:chitchat_application/Screens/Chats/components/chat_card.dart';
import 'package:chitchat_application/Screens/Messages/messages_screen.dart';
import 'package:chitchat_application/Screens/Welcome/welcome_screen.dart';
import 'package:chitchat_application/components/filled_outlline_button.dart';
import 'package:chitchat_application/constants.dart';
import 'package:chitchat_application/cubit/auth_cubit.dart';
import 'package:chitchat_application/models/chat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
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
        Expanded(
          child: BlocBuilder<AuthCubit, AuthState>(builder: (_, state) {
            if (state is AuthLogin) {
              return StreamBuilder(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child('chat_rooms')
                    .onValue,
                builder: (context, snap) {
                  if (snap.hasData && !snap.hasError) {
                    Map data = snap.data.snapshot.value;
                    print(data.keys);
                    List item = [];
                    data.keys.forEach(
                      (key) {
                        String name;
                        if (data[key]["user1"] == state.email) {
                          name = data[key]["user2"];
                          item.add(
                            Chat(
                                idRoom: key,
                                name: name,
                                image: null,
                                isActive: false,
                                lastMessage: "Glad you like it",
                                time: "18.23"),
                          );
                        } else if (data[key]["user2"] == state.email) {
                          name = data[key]["user1"];
                          item.add(
                            Chat(
                                idRoom: key,
                                name: name,
                                image: null,
                                isActive: false,
                                lastMessage: "Glad you like it",
                                time: "18.23"),
                          );
                        }
                      },
                    );
                    print(item);

                    return ListView.builder(
                      itemCount: item.length,
                      itemBuilder: (context, index) => ChatCard(
                        chat: item[index],
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessagesScreen(
                              user: item[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: chatsData.length,
                    itemBuilder: (context, index) => ChatCard(
                      chat: chatsData[index],
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagesScreen(),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ],
    );
  }
}

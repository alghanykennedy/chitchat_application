import 'package:chitchat_application/Screens/Chats/components/body.dart';
import 'package:chitchat_application/constants.dart';
import 'package:chitchat_application/cubit/auth_cubit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 1;
  TextEditingController _emailController = TextEditingController();
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actions: [
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (_, state) {
                      if (state is AuthLogin) {
                        return TextButton(
                          onPressed: () {
                            final db = FirebaseDatabase()
                                .reference()
                                .child('chat_rooms')
                                .push()
                                .set({
                              "user1": state.email,
                              "user2": _emailController.text,
                            });
                            _emailController.text = "";
                            Navigator.maybePop(context);

                            return Text("Silahkan Login terlebih dahulu");
                          },
                          child: Text("Mulai Chat"),
                        );
                      }
                    },
                  ),
                ],
                title: Text("Tambah Chat"),
                content: Container(
                  child: TextField(
                    controller: _emailController,
                    onChanged: (value) {
                      _emailController.text = value;
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(hintText: "Masukan email"),
                  ),
                ),
              );
            },
          );
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
            icon: CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage("assets/images/user_2.png"),
            ),
            label: "Profile"),
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

import 'package:chitchat_application/cubit/auth_cubit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:chitchat_application/Screens/Messages/components/chat_input_field.dart';
import 'package:chitchat_application/Screens/Messages/components/message.dart';
import 'package:chitchat_application/models/chat.dart';
import 'package:chitchat_application/models/chatmessage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  final Chat user;
  const Body(this.user, {Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List messages = [];
  @override
  void initState() {
    getMessages();
    super.initState();
  }

  Future<void> getMessages() async {
    final state = context.read<AuthCubit>().state as AuthLogin;
    final data = await FirebaseDatabase.instance
        .reference()
        .child("messages")
        // .orderByKey()
        .orderByChild("id_room")
        .equalTo(widget.user.idRoom)
        .once();
    List newMessages = [];
    print("get value once ${data.value}");
    data.value.keys.forEach((key) {
      newMessages.add(
        ChatMessage(
          messageType: ChatMessageType.text,
          messageStatus: MessageStatus.viewed,
          isSender: state.email == data.value[key]["sender"],
          text: data.value[key]["message"],
        ),
      );
    });
    setState(() {
      messages = newMessages;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(messages);
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocBuilder<AuthCubit, AuthState>(builder: (_, state) {
              if (state is AuthLogin) {
                return StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child("messages")
                      .orderByChild("id_room")
                      .equalTo(widget.user.idRoom)
                      .onChildAdded,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      final Map data = snap.data.snapshot.value;
                      // List keys = data ?? [];
                      if (data != null) {
                        // data.forEach((key) {
                        messages.add(
                          ChatMessage(
                            messageType: ChatMessageType.text,
                            messageStatus: MessageStatus.viewed,
                            isSender: state.email == data["sender"],
                            text: data["message"],
                          ),
                        );
                        // });
                        return ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) => Message(
                            message: messages[index],
                          ),
                        );
                      }
                      return Text("Send a message first");
                    }
                    return Text("Send a message first");
                  },
                );
              }
            }),
          ),
        ),
        ChatInputField(widget.user),
      ],
    );
  }
}

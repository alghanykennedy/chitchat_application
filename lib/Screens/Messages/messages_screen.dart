import 'package:chitchat_application/Screens/Messages/components/body.dart';
import 'package:chitchat_application/models/chat.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  final Chat user;

  const MessagesScreen({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(user),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          SizedBox(width: 8 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
      ],
    );
  }
}

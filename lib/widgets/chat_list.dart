import 'package:flutter/material.dart';
import 'package:whatsapp_clone_using_flutter/widgets/my_message_card.dart';
import 'package:whatsapp_clone_using_flutter/widgets/sender_message_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (context, index) {
        if (true) {//check sender or receiver
          return MyMessageCard(
            message: "",
            date: "",
          );
        }
        return SenderMessageCard(
          message: "",
          date: "",
        );
      },
    );
  }
}

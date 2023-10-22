import 'package:chat_app/ui/screens/chat/bubble_chat.dart';
import 'package:chat_app/utilits/app_color.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = "chatscreen";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.chat,color: AppColor.white,),
                SizedBox(width: 4),
                Text("Chat"),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BubbleChat(),

                TextField(
                   decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)
                         ,borderSide: BorderSide(color: Colors.black)),
                     suffixIcon: Icon(Icons.send),
                     hintText: "Enter your message",
                   ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

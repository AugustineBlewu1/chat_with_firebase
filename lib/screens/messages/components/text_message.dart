import 'package:chat/models/Chat.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class TextMessage extends StatelessWidget {
  TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
      //     ? Colors.white
      //     : Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor
            .withOpacity(message!.fromID == currentUser!.uid ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message!.lastMessage!,
            style: TextStyle(
              color: message!.fromID == currentUser!.uid
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                message!.createdOn!.toDate().hour.toString() +
                    ' : ' +
                    message!.createdOn!.toDate().minute.toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: message!.fromID == currentUser!.uid ? Colors.white : Colors.black
                ),
              ),
              SizedBox(
                width: 3.0,
              ),
             message!.fromID == currentUser!.uid ? Icon(
                Icons.done_all,
                size: 12,
                color: Colors.white,
              ) : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

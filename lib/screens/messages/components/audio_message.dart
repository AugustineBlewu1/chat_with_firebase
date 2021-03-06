import 'package:chat/models/Chat.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class AudioMessage extends StatelessWidget {
  AudioMessage({Key? key, this.message}) : super(key: key);
  final ChatMessage? message;

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kPrimaryColor
            .withOpacity(message!.fromID == currentUser!.uid ? 1 : 0.1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: message!.fromID == currentUser!.uid
                ? Colors.white
                : kPrimaryColor,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: message!.fromID == currentUser!.uid
                        ? Colors.white
                        : kPrimaryColor.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: message!.fromID == currentUser!.uid
                            ? Colors.white
                            : kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "0.37",
            style: TextStyle(
                fontSize: 12,
                color:
                    message!.fromID == currentUser!.uid ? Colors.white : null),
          ),
        ],
      ),
    );
  }
}

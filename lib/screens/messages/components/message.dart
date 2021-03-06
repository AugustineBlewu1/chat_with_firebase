import 'package:chat/models/Chat.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:chat/screens/messages/components/image_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'audio_message.dart';
import 'text_message.dart';
import 'video_message.dart';

class Message extends StatelessWidget {
   Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.type) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        case ChatMessageType.audio:
          return AudioMessage(message: message);
        case ChatMessageType.image:
          return ImageMessage(message: message, isMe:  message.fromID == currentUser!.uid ? true : false,);
        case ChatMessageType.video:
          return VideoMessage();
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Column(

        children: [
         // if(message.createdOn!.toDate() == D)
          //Text(message.createdOn!.toDate().toString()),
          Row(
            mainAxisAlignment:
                message.fromID == currentUser!.uid ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (message.fromID == currentUser!.uid) ...[
                CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage("assets/images/user_2.png"),
                ),
                SizedBox(width: kDefaultPadding / 2),
              ],
              messageContaint(message),
              //if (message.isSender) MessageStatusDot(status: message.messageStatus!.status)
            ],
          ),
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({Key? key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return kPrimaryColor;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

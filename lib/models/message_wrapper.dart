import 'dart:convert';

import 'package:chat/models/ChatMessage.dart';
import 'package:chat/nav/navigators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageWrapper extends StatelessWidget {
  final Widget child;
  final ChatMessage message;
  final bool isMe;
  const MessageWrapper(
      {Key? key,
      required this.message,
      required this.isMe,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;

    Timestamp timestamp = message.createdOn!;

    logger.v(timestamp);

    return InkWell(
      // onLongPress: () {
      //   message.ref.delete();
      // },
      child: Container(
        child: Stack(
          children: [
            Container(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              constraints: BoxConstraints(
                maxWidth: _size.width * 0.7,
                minWidth: _size.width * 0.25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  if (!isMe) ...[
                    Text(
                      message.lastMessage!,
                      maxLines: 1,
                      style: _theme.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _theme.accentColor,
                      ),
                    ),
                    SizedBox(height: 3),
                  ],
                  child,
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 15,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Text(
                          message.createdOn!.toDate().hour. toString()  +  ' : ' + message.createdOn!.toDate().minute.toString(),
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Icon(
                          Icons.done_all,
                          size: 12,
                          color: Colors.indigo[900],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:chat/models/ChatMessage.dart';
import 'package:chat/models/image_builder.dart';
import 'package:chat/models/message_wrapper.dart';
import 'package:flutter/material.dart';


class ImageMessage extends StatelessWidget {
  const ImageMessage({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  final bool isMe;
  final ChatMessage message;

  bool get _fileExists => message.asset != null
      ? File(message.asset!).existsSync()
      : false;
  @override
  Widget build(BuildContext context) {
    return  MessageWrapper(
          message: message,
          isMe: isMe,
          child: (isMe && _fileExists)
              ? ClipRRect(
                 borderRadius: BorderRadius.circular(20),
                child: Image.file(
                    File(message.asset!),
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, __, _) => buildCachedNetworkImage(),
                  ),
              )
              : buildCachedNetworkImage(),
    );
  }

  ImageBuilder buildCachedNetworkImage() {
    return ImageBuilder(
      imageUrl: message.lastMessage!,
      placeholder: (context, url) => Container(
        child: CircularProgressIndicator(),
        width: 200.0,
        height: 200.0,
        padding: EdgeInsets.all(70.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Material(
        child: Image.asset(
          'assets/images/user.png',
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        clipBehavior: Clip.hardEdge,
      ),
      width: 200.0,
      height: 200.0,
      fit: BoxFit.cover,
    );
  }
}

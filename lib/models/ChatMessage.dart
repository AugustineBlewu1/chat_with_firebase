import 'dart:convert';

import 'package:chat/screens/messages/components/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  String? name;
  String? lastMessage;
  String? image;
  String? fromID;
  String? to;
  String? asset;
  Timestamp? createdOn;
  ChatMessageType? type;
  MessageStatusDot? messageStatus;
  bool? isActive;
  ChatMessage({
    this.name,
    this.lastMessage,
    this.image,
    this.fromID,
    this.to,
    this.asset,
    this.createdOn,
    this.messageStatus,
    this.isActive,
    this.type
  });

  

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastMessage': lastMessage,
      'image': image,
      'fromID': fromID,
      'to': to,
      'asset': asset,
      'createdOn': createdOn,
      'messageStatus': messageStatus,
      'isActive': isActive,
      'type': type
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      name: map['name'],
      lastMessage: map['lastMessage'],
      image: map['image'],
      fromID: map['fromID'],
      to: map['to'],
      asset: map['asset'],
      createdOn: map['createdOn'],
      messageStatus: map['messageStatus'],
      isActive: map['isActive'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) => ChatMessage.fromMap(json.decode(source));
}

// List demeChatMessages = [
//   ChatMessage(
//     text: "Hi Sajol,",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Hello, How are you?",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "",
//     messageType: ChatMessageType.audio,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "",
//     messageType: ChatMessageType.video,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "Error happend",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_sent,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "This looks great man!!",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Glad you like it",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_view,
//     isSender: true,
//   ),
// ];

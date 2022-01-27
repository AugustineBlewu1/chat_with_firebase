import 'dart:convert';

import 'package:chat/screens/messages/components/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat/models/ChatMessage.dart';

class Chat {
  String? name;
  String? lastMessage;
  String? image;
  String? fromID;
  String? to;
  String? asset;
  FieldValue? createdOn;
  ChatMessageType? type;
  MessageStatusDot? messageStatus;
  bool? isActive;
  bool? isSender;
  Chat(
      {this.name,
      this.lastMessage,
      this.image,
      this.fromID,
      this.to,
      this.asset,
      this.createdOn,
      this.type,
      this.isActive,
      this.isSender,
      this.messageStatus});



  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastMessage': lastMessage,
      'image': image,
      'fromID': fromID,
      'to': to,
      'asset': asset,
      'createdOn': createdOn,
      'isActive': isActive ?? false,
      'type': type!.index,
      'isSender': isSender,
      'messageStatus': messageStatus
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
        name: map['name'],
        lastMessage: map['lastMessage'],
        image: map['image'],
        fromID: map['fromID'],
        to: map['to'],
        asset: map['asset'],
        createdOn: map['createdOn'],
        isActive: map['isActive'],
        type: map['type'],
        isSender: map['isSender'],
        messageStatus: map['messageStatus']
        );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));
}

// List chatsData = [
//   Chat(
//     name: "Jenny Wilson",
//     lastMessage: "Hope you are doing well...",
//     image: "assets/images/user.png",
//     time: "3m ago",
//     isActive: false,
//   ),
//   Chat(
//     name: "Esther Howard",
//     lastMessage: "Hello Abdullah! I am...",
//     image: "assets/images/user_2.png",
//     time: "8m ago",
//     isActive: true,
//   ),
//   Chat(
//     name: "Ralph Edwards",
//     lastMessage: "Do you have update...",
//     image: "assets/images/user_3.png",
//     time: "5d ago",
//     isActive: false,
//   ),
//   Chat(
//     name: "Jacob Jones",
//     lastMessage: "You’re welcome :)",
//     image: "assets/images/user_4.png",
//     time: "5d ago",
//     isActive: true,
//   ),
//   Chat(
//     name: "Albert Flores",
//     lastMessage: "Thanks",
//     image: "assets/images/user_5.png",
//     time: "6d ago",
//     isActive: false,
//   ),
//   Chat(
//     name: "Jenny Wilson",
//     lastMessage: "Hope you are doing well...",
//     image: "assets/images/user.png",
//     time: "3m ago",
//     isActive: false,
//   ),
//   Chat(
//     name: "Esther Howard",
//     lastMessage: "Hello Abdullah! I am...",
//     image: "assets/images/user_2.png",
//     time: "8m ago",
//     isActive: true,
//   ),
//   Chat(
//     name: "Ralph Edwards",
//     lastMessage: "Do you have update...",
//     image: "assets/images/user_3.png",
//     time: "5d ago",
//     isActive: false,
//   ),
// ];

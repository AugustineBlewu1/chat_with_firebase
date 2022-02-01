import 'package:chat/constants.dart';
import 'package:chat/constants/firebase_constants.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:chat/nav/navigators.dart';
import 'package:chat/widgets/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  const Body({Key? key, this.friendUid, this.friendName}) : super(key: key);
  final friendUid;
  final friendName;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CollectionReference chats = FirebaseFirestore.instance
      .collection(FirestoreConstants.pathMessageCollection);

  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  List<QueryDocumentSnapshot> chatsmessage = [];

  var chatdocumentId;
  int limit = 20;
  int limitIn = 20;
  @override
  void initState() {
    chats
        .where(FirestoreConstants.pathUserCollection,
            isEqualTo: {widget.friendUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              chatdocumentId = querySnapshot.docs.single.id;
              logger.v(chatdocumentId);
            });
          } else {
            chats.add({
              FirestoreConstants.pathUserCollection: {
                currentUserId: null,
                widget.friendUid: null
              }
            }).then((value) {
              chatdocumentId = value;

              logger.v(chatdocumentId);
            });
          }
        })
        .catchError((err) {});
    super.initState();
  }

  // _scrollListener() {
  //   if (scrollController.offset >= scrollController.position.maxScrollExtent &&
  //       !scrollController.position.outOfRange &&
  //       limit <= chatsmessage.length) {
  //     setState(() {
  //       limit += limitIn;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(FirestoreConstants.pathMessageCollection)
                .doc(chatdocumentId)
                .collection(FirestoreConstants.pathChatCollection)
                .orderBy('createdOn', descending: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("something Went Wrong"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  ],
                );
              }
              if (snapshot.hasData) {
                return Expanded(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            logger.v(snapshot.data!.docs[index].data()
                                as Map<String, dynamic>);
                            chatsmessage = snapshot.data!.docs;
                            var data = (snapshot.data!.docs[index].data()
                                as Map<String, dynamic>);

                            logger.v("data: $data");
                            //return Expanded(child: SizedBox(),);
                            return Message(
                                message: ChatMessage(
                              createdOn: data['createdOn'],
                              isActive: data['isActive'],
                              type: chatMessage(data['type']),
                              fromID: data['fromID'],
                              lastMessage: data['lastMessage'],
                              asset: data['asset'],
                            ));
                          }),
                    ),
                  ),
                );
              }

              return SizedBox();
            }),
        ChatInputField(chats: chats, chatDocID: chatdocumentId),
      ],
    );
  }

  ChatMessageType? chatMessage(int type) {
    switch (type) {
      case 0:
        return ChatMessageType.text;
      case 1:
        return ChatMessageType.audio;
      case 2:
        return ChatMessageType.image;
      case 3:
        return ChatMessageType.video;

      default:
    }
  }
}

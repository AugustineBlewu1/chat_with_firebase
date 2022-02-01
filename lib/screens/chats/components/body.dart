import 'package:chat/nav/navigators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat/components/filled_outline_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/constants/firebase_constants.dart';
import 'package:chat/models/Chat.dart';
import 'package:chat/screens/messages/message_screen.dart';

import 'chat_card.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUSer = FirebaseAuth.instance.currentUser!.uid;
    logger.v(currentUSer);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: "Recent Message"),
              SizedBox(width: kDefaultPadding),
              FillOutlineButton(
                press: () {},
                text: "Active",  
                isFilled: false,
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(FirestoreConstants.pathUserCollection)
                .where(FirestoreConstants.id, isNotEqualTo: currentUSer)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('No User to Chat with'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading'),
                );
              }
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        logger.v(snapshot.data!.docs[index].data()
                            as Map<String, dynamic>);
                        var data = (snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);
                        return ChatCard(
                          chat: Chat(
                              name: data['nickname'],
                               image: data['photoUrl'] ),
                          press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagesScreen(data: data),
                            ),
                          ),
                        );
                      }),
                );
              }
              return SizedBox();
            }),
      ],
    );
  }
}

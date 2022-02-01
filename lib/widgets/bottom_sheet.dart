
import 'package:chat/constants.dart';
import 'package:chat/constants/firebase_constants.dart';
import 'package:chat/nav/navigators.dart';
import 'package:chat/services/file_upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

bottomSheet(context,
    {ImagePicker? picker, final CollectionReference<Object?>? chats, chatID}) {
  final getData = Provider.of<ChatModel>(context, listen: false);
  return Container(
    height: 120.0,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Padding(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    color: kPrimaryColor,
                  ),
                  onPressed: () async {
                    getData.getImageCamera(picker!, context).then((res) {
                      chats!
                          .doc(chatID)
                          .collection(FirestoreConstants.pathChatCollection)
                          .add(res!)
                          .then((value) {
                        logger.v(value);
                        logger.v("Sent Succesfully");
                      });
                    });
                    Navigator.pop(context);
                  }),
              Text(
                'Camera',
                style: TextStyle(color: kPrimaryColor),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.picture_in_picture_sharp,
                    color: kPrimaryColor,
                  ),
                  onPressed: () async {
                  await  getData.getImages(picker!, context).then((res) {
                      chats!
                          .doc(chatID)
                          .collection(FirestoreConstants.pathChatCollection)
                          .add(res!)
                          .then((value) {
                        logger.v(value);
                        logger.v("Sent Succesfully");
                      });
                    });
                    Navigator.pop(context);
                  }),
              Text(
                'Gallery',
                style: TextStyle(color: kPrimaryColor),
              )
            ],
          )
        ],
      ),
    ),
  );
}

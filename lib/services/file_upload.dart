import 'dart:io';
import 'package:chat/constants/firebase_constants.dart';
import 'package:chat/models/Chat.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:chat/nav/navigators.dart';
import 'package:chat/providers/storage_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatModel extends ChangeNotifier {
  late SharedPreferences prefs;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  late Reference userChart;

  String? firebaseUser;

  ChatModel() {
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    firebaseUser = prefs.getString(FirestoreConstants.id);
    userChart = firebaseStorage
        .ref()
        .child(FirestoreConstants.pathUserCollection)
        .child(firebaseUser!);
    logger.v(userChart);
  }

  Future<Map<String, dynamic>?> getImageCamera(
      ImagePicker _picker, context) async {
    final storage = Provider.of<StorageService>(context, listen: false);

    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      print("error in camera");
      return null;
    } else {
      File selectedFile = File(image.path);

      var url = await storage.upLoadFile(
          firebaseUser!, "ChatFiles", File(image.path));

      var filename = selectedFile.path.split('/').last;
      logger.v(filename);
      if (url != null) {
        return sendFileMessage(url, ChatMessageType.image, image.path);
      } else {
        return null;
      }
    }
  }

  Future<Map<String, dynamic>?> getImages(ImagePicker _picker, context) async {
    final storage = Provider.of<StorageService>(context, listen: false);

    List<XFile>? images = await _picker.pickMultiImage();
    logger.v(images);
    if (images == null) {
      return null;
    } else {
      var urls = await storage.uploadFiles(
          id: firebaseUser!, category: "ChatFiles", files: images);
logger.v(urls);
      if (urls.isNotEmpty) {
        urls.map((url) {
          return sendFileMessage(
              url['url'], ChatMessageType.image, url['localAsset']);
        });
      } else {
        return null;
      }
    }

    logger.w(images);
  }

  Map<String, dynamic> sendFileMessage(
      String message, ChatMessageType type, String local) {
    return sendMessage(message, type: type, localAsset: local);
  }

  Map<String, dynamic> sendMessage(String message,
      {ChatMessageType type = ChatMessageType.image, String? localAsset}) {
    if (firebaseUser == null) {
      //  nav.to(PageRouter.login);
      logger.v(firebaseUser);
    }
    final chat = Chat(
      lastMessage: message,
      fromID: firebaseUser!,
      to: 'KEK',
      createdOn: FieldValue.serverTimestamp(),
      type: type,
      name: firebaseUser ?? 'Client',
      asset: localAsset!,
    );

    logger.v(chat.toMap());

    return chat.toMap();
    //this.userChart.p
  }
}

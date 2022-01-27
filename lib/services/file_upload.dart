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
    userChart = firebaseStorage.ref().child('chats').child(firebaseUser!);
    logger.v(userChart);
  }

  Future getImageCamera(ImagePicker _picker, context) async {
    final storage = Provider.of<StorageService>(context, listen: false);

    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      print("error in camera");
      return;
    } else {
      File selectedFile = File(image.path);

      var url = await storage.upLoadFile(
          firebaseUser!, "ChatFiles", File(image.path));

      if (url != null) {
        sendFileMessage(url, ChatMessageType.image, image.path);
      }
      var filename = selectedFile.path.split('/').last;
      logger.v(filename);
      //updateProfile(filename: filename, selectedFile: compressedFile);
    }

    // Utility().saveImageToPreferences(
    //     Utility().base64String(_selectedFile.readAsBytesSync()));
  }

  Future getImages(ImagePicker _picker, context) async {
    prefs = await SharedPreferences.getInstance();
    final storage = Provider.of<StorageService>(context, listen: false);

    List<XFile>? images = await _picker.pickMultiImage();

    logger.w(images);
  }

  void sendFileMessage(String message, ChatMessageType type, String local) {
    return sendMessage(message, type: type, localAsset: local);
  }

  void sendMessage(String message,
      {ChatMessageType type = ChatMessageType.text, String? localAsset}) {
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
      //this.userChart.p
  }
}

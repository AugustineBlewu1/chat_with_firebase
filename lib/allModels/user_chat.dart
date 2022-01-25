import 'package:chat/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  String? id;
  String? photoUrl;
  String? nickname;
  String? aboutMe;
  String? phoneNumber;

  UserChat(
      {required this.id,
      required this.phoneNumber,
      required this.aboutMe,
      required this.nickname,
      required this.photoUrl});

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.nickname: nickname,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
      FirestoreConstants.phoneNumber: phoneNumber
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String photoUrl = "";
    String aboutMe = "";
    String nickname = "";
    String phoneNumber = "";
    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      phoneNumber = doc.get(FirestoreConstants.phoneNumber);
    } catch (e) {}
    try {
      nickname = doc.get(FirestoreConstants.nickname);
    } catch (e) {}
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    return UserChat(
        id: doc.id,
        phoneNumber: phoneNumber,
        aboutMe: aboutMe,
        nickname: nickname,
        photoUrl: photoUrl);
  }
}

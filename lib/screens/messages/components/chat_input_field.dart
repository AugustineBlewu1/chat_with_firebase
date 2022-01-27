import 'package:chat/constants/firebase_constants.dart';
import 'package:chat/models/Chat.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:chat/nav/navigators.dart';
import 'package:chat/widgets/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    Key? key,
    this.chats,
  }) : super(key: key);

  final CollectionReference<Object?>? chats;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController textEditingController = TextEditingController();
  bool offStage = true;
  final ImagePicker _picker = ImagePicker();
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 32,
                color: Color(0xFF087949).withOpacity(0.08),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.mic, color: kPrimaryColor),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            offStage = !offStage;
                            FocusManager.instance.primaryFocus?.unfocus();
                          });
                        },
                        icon: Icon(Icons.sentiment_satisfied_alt_outlined),
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      ),
                      SizedBox(width: kDefaultPadding / 4),
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          maxLines: 4,
                          onTap: () {
                            setState(() {
                              offStage = true;
                            });
                          },
                          focusNode: FocusNode(),
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: "Type message",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              builder: (context) =>
                                  bottomSheet(context, picker: _picker),
                              context: context);
                        },
                        icon: Icon(Icons.attach_file),
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      ),
                      SizedBox(width: kDefaultPadding / 4),
                      // Icon(
                      //   Icons.camera_alt_outlined,
                      //   color: Theme.of(context)
                      //       .textTheme
                      //       .bodyText1!
                      //       .color!
                      //       .withOpacity(0.64),
                      // ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          sendMessage(
                            textEditingController.text,
                            type: ChatMessageType.text,
                          );
                        },
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Offstage(
          offstage: offStage,
          child: SizedBox(
            height: 250,
            child: EmojiPicker(
              onEmojiSelected: (Category category, Emoji emoji) {
                textEditingController.text =
                    textEditingController.text + emoji.emoji;
              },
              // onBackspacePressed: _onBackspacePressed,
              config: const Config(
                  columns: 7,
                  emojiSizeMax: 32.0,
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  initCategory: Category.RECENT,
                  bgColor: Color(0xFFF2F2F2),
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  progressIndicatorColor: Colors.blue,
                  backspaceColor: Colors.blue,
                  showRecentsTab: true,
                  recentsLimit: 28,
                  noRecentsText: 'No Recents',
                  noRecentsStyle:
                      TextStyle(fontSize: 20, color: Colors.black26),
                  categoryIcons: CategoryIcons(),
                  buttonMode: ButtonMode.MATERIAL),
            ),
          ),
        ),
      ],
    );
  }

  void sendMessage(String message,
      {ChatMessageType type = ChatMessageType.text, String? localAsset}) {
    if (message == 'null') {
      //  nav.to(PageRouter.login);
      return;
    } else {
      final chat = Chat(
        lastMessage: message,
        fromID: currentUser.uid,
        to: 'KEK',
        createdOn: FieldValue.serverTimestamp(),
        type: ChatMessageType.text,
        isSender: true,
        name: currentUser.displayName ?? 'Client',
      );
      logger.v(chat.toMap());

      widget.chats!
          .doc(FirestoreConstants.pathMessageId)
          .collection(FirestoreConstants.pathChatCollection)
          .add(chat.toMap())
          .then((value) {
        textEditingController.text = '';
      });
    }
  }
}

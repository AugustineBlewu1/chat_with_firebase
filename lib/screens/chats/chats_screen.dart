import 'dart:math';

import 'package:chat/constants.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:chat/providers/notification.dart';
import 'package:chat/providers/notification_service.dart';
import 'package:chat/screens/signinOrSignUp/signin_or_signup_screen.dart';
import 'package:chat/services/file_upload.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../nav/navigators.dart';

import 'components/body.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedIndex = 1;
  NotificationService notificationService = NotificationService();
  LocalNotification notification = LocalNotification();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // FirebaseMessaging.instance.getInitialMessage();

    // FirebaseMessaging.onMessage.listen((event) {
    //   print(event.notification!.body);
    //   print(event.notification!.title);
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   print(event.data);
    //   print(event.data['key']);
    // });

    try {
      notificationService.setUp();
      notification.setUp();
    } catch (e) {
      logger.v(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          label: "Profile",
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    final getData = Provider.of<AuthProvider>(context, listen: false);

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            getData.handleSignOut().then((value) {
              context.pushReplacement(screen: SigninOrSignupScreen());
            });
          },
        ),
      ],
    );
  }
}

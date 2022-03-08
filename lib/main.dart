import 'package:chat/constants/app_constants.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:chat/providers/storage_provider.dart';
import 'package:chat/screens/welcome/welcome_screen.dart';
import 'package:chat/services/file_upload.dart';
import 'package:chat/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    prefs: prefs,
  ));
}


class MyApp extends StatelessWidget {
  MyApp({required this.prefs});
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(
                firebaseAuth: FirebaseAuth.instance,
                googleSignIn: GoogleSignIn(),
                prefs: this.prefs,
                firebaseFirestore: this.firebaseFirestore)),
        ChangeNotifierProvider<ChatModel>(create: (_) => ChatModel()),
        ChangeNotifierProvider<StorageService>(create: (_) => StorageService()),
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        home: WelcomeScreen(),
      ),
    );
  }
}

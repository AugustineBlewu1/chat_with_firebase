import 'package:chat/constants.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:chat/screens/chats/chats_screen.dart';
import 'package:chat/screens/signinOrSignUp/signin_or_signup_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../nav/navigators.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      checkedSignedIn();
    });

    super.initState();
  }

  void checkedSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();

    bool isLoggedIn = await authProvider.isLoggedIn();
    logger.v(isLoggedIn);
    if (isLoggedIn) {
      context.pushReplacement(screen: ChatsScreen());
      return;
    }
    context.pushReplacement(screen: SigninOrSignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    //final state = AppLifecycleState.resumed;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(flex: 2),
            Image.asset("assets/images/welcome_image.png"),
            Spacer(flex: 3),
            Text(
              "Welcome to our freedom \nmessaging app",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              "Freedom talk any person of your \nmother language.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.64),
              ),
            ),
            Spacer(flex: 3),
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
            // FittedBox(
            //   child: TextButton(
            //       onPressed: () => Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => SigninOrSignupScreen(),
            //             ),
            //           ),
            //       child: Row(
            //         children: [
            //           Text(
            //             "Skip",
            //             style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //                   color: Theme.of(context)
            //                       .textTheme
            //                       .bodyText1!
            //                       .color!
            //                       .withOpacity(0.8),
            //                 ),
            //           ),
            //           SizedBox(width: kDefaultPadding / 4),
            //           Icon(
            //             Icons.arrow_forward_ios,
            //             size: 16,
            //             color: Theme.of(context)
            //                 .textTheme
            //                 .bodyText1!
            //                 .color!
            //                 .withOpacity(0.8),
            //           )
            //         ],
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}

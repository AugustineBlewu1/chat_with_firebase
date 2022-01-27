import 'package:chat/components/primary_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:chat/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../nav/navigators.dart';

class SigninOrSignupScreen extends StatefulWidget {
  @override
  State<SigninOrSignupScreen> createState() => _SigninOrSignupScreenState();
}

class _SigninOrSignupScreenState extends State<SigninOrSignupScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in Fail");
        break;

      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign In Created");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign In Success");
        break;
      default:
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Spacer(flex: 2),
              Image.asset(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? "assets/images/Logo_light.png"
                    : "assets/images/Logo_dark.png",
                height: 146,
              ),
              Spacer(),
              PrimaryButton(
                text: "Sign In With Google",
                press: () async {
                  bool isSuccess = await authProvider.handleSignIn();
                  if (isSuccess) {
                    context.pushReplacement(screen: ChatsScreen());
                  }

                  // context.push(screen: ChatsScreen());
                },
              ),
              Center(
                  child: authProvider.status == Status.authenticating
                      ? CircularProgressIndicator()
                      : SizedBox()),
              // SizedBox(height: kDefaultPadding * 1.5),
              // PrimaryButton(
              //   color: Theme.of(context).colorScheme.secondary,
              //   text: "Sign Up",
              //   press: () {},
              // ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

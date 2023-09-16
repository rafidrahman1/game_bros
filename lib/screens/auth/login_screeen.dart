import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:game_bros/helper/dialogs.dart';
import 'package:game_bros/main.dart';
import 'package:game_bros/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../api/apis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgressbar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else {
          await APIs.creteUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      await InternetAddress.lookup('google.com');

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'Something went wrong. (Check Internet)');
      return null;
    }

    //signout funciton
    // _singOut() async {
    //   await APIs.auth.signOut();
    //   await GoogleSignIn().signOut();
    // }
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    // mq = MediaQuery.of(context).size;
    return Scaffold(
        //body
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Stack(
          //app logo
          children: [
            Positioned(
                top: mq.height * .15,
                width: mq.width * .5,
                left: mq.width * .25,
                height: mq.width * .5,
                child: FadeTransition(
                    opacity: _animation,
                    child: Image.asset('images/icon.png'))),
            //sign with google button
            Positioned(
                bottom: mq.height * .10,
                width: mq.width * .8,
                left: mq.width * .1,
                height: mq.width * .12,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        shape: const StadiumBorder(),
                        elevation: 1),
                    onPressed: () {
                      _handleGoogleBtnClick();
                    },
                    icon: Image.asset(
                      'images/google.png',
                      height: mq.height * .04,
                    ),
                    label: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 17,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                            children: [
                          TextSpan(text: 'Login with '),
                          TextSpan(
                              text: 'Google',
                              style: TextStyle(fontWeight: FontWeight.w500))
                        ])))),
          ],
        ));
  }
}

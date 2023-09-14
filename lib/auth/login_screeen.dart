import 'dart:html';

import 'package:flutter/material.dart';
import 'package:game_bros/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Stack(
          children: [
            Positioned(
                top: mq.height * .10,
                width: mq.width * .3,
                left: mq.width * .35,
                child: Image.asset('images/icon.png')),
            Positioned(
                bottom: mq.height * .10,
                width: mq.width * .8,
                left: mq.width * .1,
                height: mq.width * .07,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        shape: const StadiumBorder(),
                        elevation: 1),
                    onPressed: () {},
                    icon: Image.asset(
                      'images/google.png',
                      height: mq.height * .06,
                    ),
                    label: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 17,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                            children: [
                          TextSpan(text: 'Sign In with '),
                          TextSpan(
                              text: 'Google',
                              style: TextStyle(fontWeight: FontWeight.w500))
                        ])))),
          ],
        ));
  }
}

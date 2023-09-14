import 'package:flutter/material.dart';
import 'package:game_bros/main.dart';
import 'package:game_bros/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;
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
                child: Image.asset('images/icon.png')),
            Positioned(
                bottom: mq.height * .15,
                width: mq.width,
                child: const Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                    "Khelboiiii 👊")),
          ]),
    );
  }
}

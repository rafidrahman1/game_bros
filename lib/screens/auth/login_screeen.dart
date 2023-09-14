import 'package:flutter/material.dart';
import 'package:game_bros/main.dart';
import 'package:game_bros/screens/home_screen.dart';

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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeScreen()));
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

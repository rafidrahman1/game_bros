import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_bros/screens/auth/login_screeen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api/apis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.limeAccent,
        leading: Icon(CupertinoIcons.home),
        title: const Text('Lemon Soda'),
        actions: [
          //Search Button
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          //Burger
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        //New Conversation
        child: FloatingActionButton(
            onPressed: () async {
              // signout funciton
              await APIs.auth.signOut();
              await GoogleSignIn().signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
            child: const Icon(Icons.add_comment_sharp)),
      ),
    );
  }
}

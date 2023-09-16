import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_bros/model/chat_user.dart';
import 'package:game_bros/screens/auth/login_screeen.dart';
import 'package:game_bros/screens/profile_screen.dart';
import 'package:game_bros/widgets/chat_user_card.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api/apis.dart';
import 'package:game_bros/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.limeAccent,
        leading: Icon(CupertinoIcons.home),
        title: const Text('Lemon Soda'),
        actions: [
          //Search Button
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          //Burger
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfileScreen(user: list[0])));
              },
              icon: const Icon(Icons.more_vert))
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
      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            //if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                    itemCount: list.length,
                    padding: EdgeInsets.only(top: mq.height * .01),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (contex, index) {
                      return ChatUserCard(user: list[index]);
                      // return Text('Name: ${list[index]}');
                    });
              } else {
                return const Center(
                    child: Text("No Connections Found!",
                        style: TextStyle(fontSize: 20)));
              }
          }
        },
      ),
    );
  }
}

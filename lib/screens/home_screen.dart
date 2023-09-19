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
  List<ChatUser> _list = [];
  final List<ChatUser> _searchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //hide keyboard when tap anywhere on screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        //when search is on if user press back button it will not close application
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: Colors.limeAccent,
            leading: Icon(CupertinoIcons.home),
            title: _isSearching
                ? TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name, Email, ....'),
                    autofocus: true,
                    // style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                    //when search text changes them update searchlist
                    onChanged: (val) {
                      //search logic
                      _searchList.clear();
                      for (var i in _list) {
                        if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                            i.email.toLowerCase().contains(val.toLowerCase())) {
                          _searchList.add(i);
                        }
                      }
                      setState(() {
                        _searchList;
                      });
                    },
                  )
                : Text('Lemon Soda'),
            actions: [
              //Search Button
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : Icons.search)),

              //Burger
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProfileScreen(user: APIs.me)));
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: const Icon(Icons.add_comment_sharp)),
          ),
          body: StreamBuilder(
            stream: APIs.getAllUsers(),
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
                  _list =
                      data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                          [];

                  if (_list.isNotEmpty) {
                    return ListView.builder(
                        itemCount:
                            _isSearching ? _searchList.length : _list.length,
                        padding: EdgeInsets.only(top: mq.height * .01),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (contex, index) {
                          return ChatUserCard(
                              user: _isSearching
                                  ? _searchList[index]
                                  : _list[index]);
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
        ),
      ),
    );
  }
}

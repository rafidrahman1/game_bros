import 'package:flutter/cupertino.dart';
import 'package:clear_all_notifications/clear_all_notifications.dart';
import 'package:flutter/material.dart';
import 'package:game_bros/api/apis.dart'; // Import the APIs class
import 'package:game_bros/model/message.dart';
import 'package:game_bros/screens/home_screen.dart';
import 'package:game_bros/widgets/message_card.dart'; // Import the new MessageCard widget

import '../main.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);
  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Message> _groupMessages = [];
  final TextEditingController _textController = TextEditingController();
  final List<Message> _searchList = [];
  late final FocusNode _textFieldFocusNode;
  // for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Initialize user data when the chat screen is created

    ClearAllNotifications.clear();

    // Load group messages for the specified group
    _loadGroupMessages();

    _textFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  // Load group messages for the specified group
  void _loadGroupMessages() {
    APIs.getAllGroupMessages(groupId).listen((messages) {
      setState(() {
        _groupMessages =
            messages.docs.map((e) => Message.fromJson(e.data())).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        dq = '';
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
              icon: Icon(
                Icons.home,
                color: Colors.black54,
              ),
            ),
            title: _isSearching
                ? TextField(
                    autofocus: true,
                    onChanged: (val) {
                      _searchList.clear();

                      for (var i in _groupMessages) {
                        if (i.msg.toLowerCase().contains(val.toLowerCase())) {
                          _searchList.add(i);
                          setState(() {
                            _searchList;
                          });
                        }
                      }
                    },
                  )
                : Text('Lemon Soda'),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching ? Icons.clear : Icons.search))
            ],
          ),
          backgroundColor: Color.fromRGBO(234, 237, 244, 1),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount:
                      _isSearching ? _searchList.length : _groupMessages.length,
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MessageCard(
                      reply: _groupMessages[index].rePly,
                      currentUser: APIs.me,
                      message: _isSearching
                          ? _searchList[index]
                          : _groupMessages[index],
                      senderImage: _groupMessages[index].senderImage,
                      senderName: _groupMessages[index].senderName,
                    );
                  },
                ),
              ),
              chatInput()
            ],
          ),
        ),
      ),
    );
  }

  Widget chatInput() {
    String hintTex = dq;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                SizedBox(width: 13),
                Expanded(
                  child: TextField(
                    focusNode: _textFieldFocusNode,
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: hintTex,
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 141, 154, 176),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.emoji_emotions,
                    color: const Color.fromARGB(255, 209, 226, 255),
                    size: 20,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 10),
                CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.image,
                    color: const Color.fromARGB(255, 209, 226, 255),
                    size: 20,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 10),
                MaterialButton(
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      // Send a group message with sender's name and image
                      APIs.sendGroupMessage(
                        dq,
                        groupId,
                        _textController.text,
                        Type.text,
                        APIs.me.name, // Provide sender's name
                        APIs.me.image, // Provide sender's image URL
                      );
                    }
                    _textController.text = '';
                    dq = '';
                  },
                  minWidth: 0,
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color.fromRGBO(39, 193, 167, 1),
                  child: Icon(
                    Icons.telegram,
                    color: Colors.white,
                    size: 26,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

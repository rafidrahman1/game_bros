import 'package:flutter/cupertino.dart';
import 'package:clear_all_notifications/clear_all_notifications.dart';
import 'package:flutter/material.dart';
import 'package:game_bros/api/apis.dart'; // Import the APIs class
import 'package:game_bros/model/message.dart';
import 'package:game_bros/widgets/message_card.dart'; // Import the new MessageCard widget

import '../main.dart';

class ChatScreenState extends StatefulWidget {
  final String groupId; // Pass the group ID to the chat screen

  const ChatScreenState({Key? key, required this.groupId}) : super(key: key);

  @override
  State<ChatScreenState> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenState> {
  List<Message> _groupMessages = []; // Store group messages
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize user data when the chat screen is created
    APIs.initializeUserData();
    ClearAllNotifications.clear();

    // Load group messages for the specified group
    _loadGroupMessages();
  }

  // Load group messages for the specified group
  void _loadGroupMessages() {
    APIs.getAllGroupMessages(widget.groupId).listen((messages) {
      setState(() {
        _groupMessages =
            messages.docs.map((e) => Message.fromJson(e.data())).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(246, 247, 249, 1),
            flexibleSpace: _appBar(),
          ),
          backgroundColor: Color.fromRGBO(234, 237, 244, 1),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse:
                      true, // Reverse the list to display messages from bottom to top
                  itemCount: _groupMessages.length,
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MessageCard(
                      message: _groupMessages[index],
                      currentUser: APIs.me,
                      senderName: _groupMessages[index]
                          .senderName, // Provide sender's name here
                    );
                  },
                ),
              ),
              _chatInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lemon Soda', // Replace with the group name
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Spacer(),
        // You can add the group image here
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  SizedBox(width: 13),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Write your message...',
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
                          widget.groupId,
                          _textController.text,
                          Type.text,
                          APIs.me.name, // Provide sender's name
                          APIs.me.image, // Provide sender's image URL
                        );
                      }
                      _textController.text = '';
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
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_bros/main.dart';
import 'package:game_bros/model/chat_user.dart';

import '../api/apis.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),

        //body
        body: Column(children: [
          Expanded(
            child: StreamBuilder(
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
                    // final data = snapshot.data?.docs;
                    // _list =
                    //     data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                    //         [];

                    final _list = [];

                    if (_list.isNotEmpty) {
                      return ListView.builder(
                          itemCount: _list.length,
                          padding: EdgeInsets.only(top: mq.height * .01),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (contex, index) {
                            return Text('Message: ${_list[index]}');
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
          _chatInput()
        ]),
      ),
    );
  }

//app bar widget
  Widget _appBar() {
    return Row(
      children: [
        //back button
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            )),
        //name
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user.name,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),

        Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          //chat image
          child: CachedNetworkImage(
              width: mq.height * .045,
              height: mq.height * .045,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(CupertinoIcons.person))),
        ),
        SizedBox(width: 10)
      ],
    );
  }

//bottom chat input field
  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.blueAccent,
                      )),
                  //text field
                  const Expanded(
                      child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: 'Kirree momma',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 209, 226, 255)),
                        border: InputBorder.none),
                  )),
                  //gallery button
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.image,
                        color: Colors.blueAccent,
                      )),
                  //camera button
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.blueAccent,
                      )),
                  SizedBox(width: mq.width * .03)
                ],
              ),
            ),
          ),
          //send message button
          MaterialButton(
            onPressed: () {},
            minWidth: 0,
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.blueAccent,
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}

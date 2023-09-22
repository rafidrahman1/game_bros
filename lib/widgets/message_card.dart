import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_bros/model/message.dart';

import '../main.dart';
import '../model/chat_user.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({
    Key? key,
    required this.message,
    required this.currentUser,
    required this.senderName,
    required this.senderImage, // Add senderName parameter
  }) : super(key: key);

  final Message message;
  final ChatUser currentUser;
  final String senderImage;
  final String senderName; // Add this line

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return widget.currentUser.id == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  // Your message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Row(
        //   children: [
        //     //for adding some space
        //     SizedBox(width: mq.width * .04),
        //     Text(
        //       MyDateUtil.getFormattedTime(
        //           context: context, time: widget.message.sent),
        //       style: const TextStyle(fontSize: 13, color: Colors.black54),
        //     ),
        //   ],
        // ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(
              left: 80,
              right: 10,
              top: 5,
              bottom: 5,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(184, 194, 208, 232),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Text(
              widget.message.msg,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }

  // Other user's message
  Widget _blueMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: .2, left: 10),
          child: Text(
            widget.senderName, // Display sender's name
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: .2, left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  width: mq.height * .05,
                  height: mq.height * .05,
                  imageUrl: widget.senderImage,
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                  left: 10,
                  right: 80,
                  top: 5,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 253),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Text(
                  widget.message.msg,
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

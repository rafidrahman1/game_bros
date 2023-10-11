import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:game_bros/model/message.dart';
import '../helper/my_date_util.dart';
import '../main.dart';
import '../model/chat_user.dart';

class MessageCard extends StatefulWidget {
  MessageCard({
    Key? key,
    required this.message,
    required this.currentUser,
    required this.senderName,
    required this.senderImage,
    required this.reply,
  }) : super(key: key);

  final Message message;
  final ChatUser currentUser;
  final String senderImage;
  final String senderName;
  final String reply;

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
    String hins = widget.reply;
    if (hins != "") {
      hins += ' => \n';
    }
    return ChatBubble(
      clipper: ChatBubbleClipper2(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(bottom: 7, right: 4),
      backGroundColor: Color.fromARGB(184, 194, 208, 232),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onLongPress: () {
              setState(() {
                Clipboard.setData(ClipboardData(text: widget.message.msg));
              });
            },
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  //real message
                  TextSpan(
                    text: hins + widget.message.msg + '  ',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),

                  //time
                  TextSpan(
                      text: MyDateUtil.getFormattedTime(
                          context: context, time: widget.message.sent),
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(78, 78, 78, 0.639))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Other user's message
  Widget _blueMessage() {
    // if (widget.message.read.isEmpty) {
    //   APIs.updateMessageReadStatus(widget.message);
    // }

    String hins = widget.reply;
    if (hins != "") {
      hins += ' => \n';
    }
    return Row(
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: CachedNetworkImage(
                  width: mq.height * .05,
                  height: mq.height * .05,
                  imageUrl: widget.senderImage,
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),
            ),
            ChatBubble(
              margin: EdgeInsets.only(left: 40, bottom: 7),
              clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
              backGroundColor: Color.fromARGB(255, 255, 255, 253),
              child: InkWell(
                onDoubleTap: () {
                  dq = widget.message.msg;
                },
                onLongPress: () {
                  setState(() {
                    Clipboard.setData(ClipboardData(text: widget.message.msg));
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.senderName,
                          // Display sender's name
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          )),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            //real message
                            TextSpan(
                              text: hins + widget.message.msg + '  ',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: const Color.fromARGB(238, 0, 0, 0)),
                            ),

                            //time
                            TextSpan(
                                text: MyDateUtil.getFormattedTime(
                                    context: context,
                                    time: widget.message.sent),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(78, 78, 78, 0.639))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

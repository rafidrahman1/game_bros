import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_bros/main.dart';
import 'package:game_bros/model/chat_user.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .01, vertical: 4),
      // color: Colors.blue.shade100,
      elevation: .5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          // leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
          //user profile picture from gmail
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              width: mq.height * .055,
              height: mq.height * .055,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(CupertinoIcons.person)),
            ),
          ),
          title: Text(widget.user.name),
          subtitle: Text('Last user message', maxLines: 1),
          trailing: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: Colors.greenAccent.shade400,
                borderRadius: BorderRadius.circular(10)),
          ),
          // trailing: Text('12:00 PM'),
        ),
      ),
    );
  }
}

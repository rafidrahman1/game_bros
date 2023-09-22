// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:game_bros/api/apis.dart';
// import 'package:game_bros/helper/my_date_util.dart';
// import 'package:game_bros/main.dart';
// import 'package:game_bros/model/chat_user.dart';
// import 'package:game_bros/model/message.dart';


// class ChatUserCard extends StatefulWidget {
//   final ChatUser user;
//   const ChatUserCard({super.key, required this.user});

//   @override
//   State<ChatUserCard> createState() => _ChatUserCardState();
// }

// class _ChatUserCardState extends State<ChatUserCard> {
//   //last message info (if null --> no message)
//   Message? _message;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: mq.width * .01, vertical: 4),
//       // color: Colors.blue.shade100,
//       elevation: .5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: InkWell(
//           onTap: () {
//             //for navigating to chat screen
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => ChatScreen(
//                           user: widget.user,
//                         )));
//           },
//           child: StreamBuilder(
//             stream: APIs.getLastMessage(widget.user),
//             builder: (context, snapshot) {
//               final data = snapshot.data?.docs;
//               final list =
//                   data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
//               if (list.isNotEmpty) _message = list[0];

//               return ListTile(
//                 // leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
//                 //user profile picture from gmail
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   //chat image
//                   child: CachedNetworkImage(
//                     width: mq.height * .055,
//                     height: mq.height * .055,
//                     imageUrl: widget.user.image,
//                     errorWidget: (context, url, error) =>
//                         const CircleAvatar(child: Icon(CupertinoIcons.person)),
//                   ),
//                 ),
//                 title: Text(widget.user.name),
//                 //last message
//                 subtitle: Text(
//                     _message != null ? _message!.msg : widget.user.about,
//                     maxLines: 1),
//                 //last message time
//                 trailing: _message == null
//                     ? null //show nothing when no message is sent
//                     : _message!.read.isEmpty &&
//                             _message!.fromId != APIs.user.uid
//                         ?
//                         //show for unread message
//                         Container(
//                             margin: EdgeInsets.symmetric(horizontal: 10),
//                             width: 15,
//                             height: 15,
//                             decoration: BoxDecoration(
//                                 color: Colors.greenAccent.shade400,
//                                 borderRadius: BorderRadius.circular(10)),
//                           )
//                         :
//                         //message sent time
//                         Text(
//                             MyDateUtil.getLastMessageTime(
//                                 context: context, time: _message!.sent),
//                             style: const TextStyle(color: Colors.black54),
//                           ),
//                 // trailing: Text('12:00 PM'),
//               );
//             },
//           )),
//     );
//   }
// }

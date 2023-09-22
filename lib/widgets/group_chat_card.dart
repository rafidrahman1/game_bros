// import 'package:flutter/material.dart';
// import 'package:game_bros/model/group_chat.dart';

// import '../main.dart';
// import '../model/message.dart';

// class GroupChatCard extends StatefulWidget {
//   final GroupChat groupChat;

//   GroupChatCard({required this.groupChat});
//   @override
//   State<GroupChatCard> createState() => _GroupChatCardState();
// }

// class _GroupChatCardState extends State<GroupChatCard> {
//   //last message info (if null --> no message)
//   Message? _message;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: mq.width * .01, vertical: 4),
//       elevation: .5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: InkWell(
//         onTap: () {
//           // Handle tapping on the group chat card (e.g., navigate to the group chat screen).
//           // You can define the behavior based on your app's requirements.
//         },
//         child: ListTile(
//           leading: CircleAvatar(
//             child: Icon(Icons.group),
//             // You can customize the group chat avatar as needed.
//           ),
//           title: Text(widget.groupChat.groupName),
//           subtitle: Text("Group Chat"),
//           // trailing: Text(
//           //   // You can customize the last active time or other information as needed.
//           //   "Last Active: ${groupChat.lastActive}",
//           //   style: TextStyle(color: Colors.black54),
//           // ),
//         ),
//       ),
//     );
//   }
// }

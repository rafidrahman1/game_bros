// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../api/apis.dart';
// import '../model/message.dart';

// class ChatInput extends StatefulWidget {
//   const ChatInput({super.key});

//   @override
//   State<ChatInput> createState() => _ChatInputState();
// }

// class _ChatInputState extends State<ChatInput> {
//   final TextEditingController _textController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//       child: Row(
//         children: [
//           Expanded(
//             child: Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Row(
//                 children: [
//                   SizedBox(width: 13),
//                   Expanded(
//                     child: TextField(
//                       controller: _textController,
//                       keyboardType: TextInputType.multiline,
//                       maxLines: null,
//                       decoration: InputDecoration(
//                         hintText: 'Write your message...',
//                         hintStyle: TextStyle(
//                           color: Color.fromARGB(255, 141, 154, 176),
//                         ),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   CupertinoButton(
//                     minSize: double.minPositive,
//                     padding: EdgeInsets.zero,
//                     child: Icon(
//                       Icons.emoji_emotions,
//                       color: const Color.fromARGB(255, 209, 226, 255),
//                       size: 20,
//                     ),
//                     onPressed: () {},
//                   ),
//                   SizedBox(width: 10),
//                   CupertinoButton(
//                     minSize: double.minPositive,
//                     padding: EdgeInsets.zero,
//                     child: Icon(
//                       Icons.image,
//                       color: const Color.fromARGB(255, 209, 226, 255),
//                       size: 20,
//                     ),
//                     onPressed: () {},
//                   ),
//                   SizedBox(width: 10),
//                   MaterialButton(
//                     onPressed: () {
//                       if (_textController.text.isNotEmpty) {
//                         // Send a group message with sender's name and image
//                         APIs.sendGroupMessage(
//                           widget.groupId,
//                           _textController.text,
//                           Type.text,
//                           APIs.me.name, // Provide sender's name
//                           APIs.me.image, // Provide sender's image URL
//                         );
//                       }
//                       _textController.text = '';
//                     },
//                     minWidth: 0,
//                     padding: EdgeInsets.all(5),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     color: Color.fromRGBO(39, 193, 167, 1),
//                     child: Icon(
//                       Icons.telegram,
//                       color: Colors.white,
//                       size: 26,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

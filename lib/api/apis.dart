import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:game_bros/model/chat_user.dart';
import 'package:game_bros/model/message.dart';
import 'package:http/http.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;
  static FirebaseMessaging fmessaging = FirebaseMessaging.instance;
  static String? t;

  static Future<void> getFirebaseMessagingToken() async {
    await fmessaging.requestPermission();
    fmessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        APIs.updateActiveStatus(true);
        log('Push Token: $t');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foregroung!');
      log('Message data: ${message.data}');
      if (message.notification != null) {
        log('Message also contained a notificaiton: ${message.notification}');
      }
    });
  }

  static Future<void> sendPushNotification(
      ChatUser chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": me.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        "data": {
          "some_data": "User ID: ${me.id}",
        },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                ''
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> initializeUserData() async {
    await getSelfInfo();
  }

  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        await getFirebaseMessagingToken();
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      image: user.photoURL.toString(),
      about: "Hey, I'm using We Chat!",
      isOnline: false,
      lastActive: time,
      pushToken: '',
      isGroupChat: true,
      groupChatIds: [defaultGroupId], // Add the default group chat ID
    );
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllGroupMessages(
      String groupId) {
    return firestore
        .collection('group_chats/$groupId/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  static Future<void> sendGroupMessage(
    String groupId,
    String msg,
    Type type,
    String senderName, // Add sender's name parameter
    String senderImage, // Add sender's image URL parameter
  ) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final Message message = Message(
      id: time,
      toId: groupId,
      msg: msg,
      read: '',
      type: type,
      fromId: user.uid,
      sent: time,
      senderName: senderName, // Use the provided sender's name
      senderImage: senderImage, // Use the provided sender's image URL
    );

    final ref = firestore.collection('group_chats/$groupId/messages/');
    await ref.doc(time).set(message.toJson());

    // Get all users in the group except the sender (current user)
    final users = await firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .get();

    // Send push notifications to all users in the group except the sender
    for (final userDoc in users.docs) {
      final chatUser = ChatUser.fromJson(userDoc.data());
      log('$userDoc');
      await sendPushNotification(chatUser, type == Type.text ? msg : 'image');
    }
  }

  static const String defaultGroupId =
      'your_default_group_id'; // Replace with your default group ID
  static ChatUser me = ChatUser(
    id: '',
    name: '',
    email: '',
    image: '',
    about: '',
    isOnline: false,
    lastActive: '',
    pushToken: '',
    isGroupChat: true,
    groupChatIds: [],
  );

  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }
}

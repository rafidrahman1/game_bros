class ChatUser {
  late String image;
  late String name;
  late String email;
  late bool isOnline;
  late String id;
  late String lastActive;
  late String pushToken;
  late String about;
  late bool isGroupChat;
  late List<String> groupChatIds;

  ChatUser({
    required this.image,
    required this.name,
    required this.email,
    required this.isOnline,
    required this.lastActive,
    required this.pushToken,
    required this.id,
    required this.about,
    required this.isGroupChat,
    required this.groupChatIds,
  });

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    isOnline = json['is_online'] ?? false;
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    pushToken = json['push_token'] ?? '';
    about = json['about'] ?? '';
    isGroupChat = json['isGroupChat'] ?? false;
    groupChatIds = List<String>.from(json['groupChatIds'] ?? <String>[]);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['email'] = email;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['push_token'] = pushToken;
    data['about'] = about;
    data['isGroupChat'] = isGroupChat;
    data['groupChatIds'] = groupChatIds;
    return data;
  }
}

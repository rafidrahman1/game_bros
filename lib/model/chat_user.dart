class ChatUser {
  ChatUser({
    required this.image,
    required this.name,
    required this.email,
    required this.isOnline,
    required this.lastActive,
    required this.pushToken,
    required this.id,
    required this.about,
  });
  late String image;
  late String name;
  late String email;
  late bool isOnline;
  late String id;
  late String lastActive;
  late String pushToken;
  late String about;

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    isOnline = json['is_online'] ?? '';
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    pushToken = json['push_token'] ?? '';
    about = json['about'] ?? '';
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
    return data;
  }
}

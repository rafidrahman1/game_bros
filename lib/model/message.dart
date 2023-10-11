class Message {
  Message({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
    required this.senderName, // Add sender's name field
    required this.senderImage,
    required this.rePly, // Add sender's image URL field
  });
  late final String rePly;
  late final String toId;
  late final String msg;
  late final String read;
  late final String fromId;
  late final String sent;
  late final Type type;
  late final String senderName; // Sender's name
  late final String senderImage; // Sender's image URL

  Message.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromId = json['fromId'].toString();
    rePly = json['rePly'].toString();
    sent = json['sent'].toString();
    senderName = json['senderName'].toString();
    senderImage = json['senderImage'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['rePly'] = rePly;
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    data['senderName'] = senderName;
    data['senderImage'] = senderImage; // Serialize the sender's name
    return data;
  }
}

enum Type { text, image }

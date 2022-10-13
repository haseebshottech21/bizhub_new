// class Message {
//   Message({
//     // required this.id,
//     this.text,
//     this.type,
//     this.attachment,
//     this.voice,
//     required this.createdAt,
//     required this.isMe,
//   });

//   // int id;
//   String? text;
//   String? type;
//   String? attachment;
//   String? voice;
//   String createdAt;
//   bool isMe;

//   Message copyWith({
//     // required int id,
//     String? text,
//     String? type,
//     String? attachment,
//     String? voice,
//     required String createdAt,
//     required bool isMe,
//   }) =>
//       Message(
//         // id: id,
//         text: text,
//         type: type,
//         attachment: attachment,
//         voice: voice,
//         isMe: isMe,
//         createdAt: createdAt,
//       );

//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//         // id: json["id"],
//         text: json["text"],
//         type: json["type"],
//         attachment: json["attachment"],
//         voice: json["voice"],
//         isMe: json["isMe"],
//         createdAt: json["createdAt"],
//       );

//   Map<String, dynamic> toJson() => {
//         // "id": id,
//         "text": text,
//         "type": type,
//         "attachment": attachment,
//         "voice": voice,
//         "isMe": isMe,
//         "createdAt": createdAt,
//       };
// }

class MessageModel {
  String? messageId;
  String? chatId;
  String? receiverId;
  String? senderId;
  String? message;
  String? offer;
  bool? isMe;
  String? createdAt;

  MessageModel({
    this.messageId,
    this.chatId,
    this.receiverId,
    this.senderId,
    this.message,
    this.offer,
    this.isMe,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messageId: json['id'].toString(),
        chatId: json['chat_id'].toString(),
        receiverId: json['receiver_id'].toString(),
        senderId: json['sender_id'].toString(),
        message: json['message'],
        offer: json['offer'],
        isMe: json['is_me'],
        createdAt: json['created_at'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': messageId,
        'chat_id': chatId,
        'receiver_id': receiverId,
        'sender_id': senderId,
        'message': message,
        'offer': offer,
        'is_me': isMe,
        'created_at': createdAt,
      };
}

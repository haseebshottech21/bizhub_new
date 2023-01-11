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

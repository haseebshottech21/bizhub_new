import 'package:bizhub_new/model/message_model.dart';
import 'package:bizhub_new/model/service_model.dart';
import 'package:bizhub_new/model/user_model.dart';

class Chat {
  int id;
  String username;
  String postTitle;
  String message;
  int? unReadCount;
  String lastMessageAt;

  Chat({
    required this.id,
    required this.username,
    required this.postTitle,
    required this.message,
    this.unReadCount,
    required this.lastMessageAt,
  });

  Chat copyWith({
    // String? text,
    // String? description,
    // String? subDes,
    // String? image,
    int? id,
    String? username,
    String? postTitle,
    String? message,
    int? unReadCount,
    String? lastMessageAt,
  }) {
    return Chat(
      id: id ?? this.id,
      username: username ?? this.username,
      postTitle: postTitle ?? this.postTitle,
      message: message ?? this.message,
      unReadCount: unReadCount ?? this.unReadCount,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'postTitle': postTitle,
      'message': message,
      'unReadCount': unReadCount,
      'lastMessageAt': lastMessageAt
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      postTitle: map['postTitle'] ?? '',
      message: map['message'] ?? '',
      unReadCount: map['unReadCount'] ?? '',
      lastMessageAt: map['lastMessageAt'] ?? '',
    );
  }
}

class ChatModel {
  String? chatId;
  String? receiverId;
  String? senderId;
  String? serviceId;
  MessageModel? message;
  ServiceModel? service;
  UserModel? user;

  ChatModel({
    this.chatId,
    this.receiverId,
    this.senderId,
    this.serviceId,
    this.message,
    this.service,
    this.user,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chatId: json['id'].toString(),
        receiverId: json['receiver_id'].toString(),
        senderId: json['sender_id'].toString(),
        serviceId: json['service_id'].toString(),
        message: MessageModel.fromJson(json['message']),
        service: ServiceModel.fromJson(json['service']),
        user: UserModel.fromJson(json['sender_details']),
      );

  Map<String, dynamic> toJson() => {
        'id': serviceId,
        'receiver_id': receiverId,
        'sender_id': senderId,
        'service_id': serviceId,
        'message': message,
        'service': service,
        'sender_details': user,
      };
}

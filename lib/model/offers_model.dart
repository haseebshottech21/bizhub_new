import 'package:bizhub_new/model/user_model.dart';

class OfferModel {
  String? id;
  String? receiverId;
  String? senderId;
  String? serviceId;
  String? createAt;
  UserModel? user;

  OfferModel({
    this.id,
    this.receiverId,
    this.senderId,
    this.serviceId,
    this.createAt,
    this.user,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json['id'].toString(),
        receiverId: json['receiver_id'].toString(),
        senderId: json['sender_id'].toString(),
        serviceId: json['service_id'].toString(),
        createAt: json['created_at'].toString(),
        user: UserModel.fromJson(json['sender_details']),
      );

  Map<String, dynamic> toJson() => {
        'id': serviceId,
        'receiver_id': receiverId,
        'sender_id': senderId,
        'service_id': serviceId,
        'created_at': createAt,
        'sender_details': user,
      };
}

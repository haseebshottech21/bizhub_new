import 'package:bizhub_new/model/offers_model.dart';
import 'package:bizhub_new/model/service_images_model.dart';
import 'package:bizhub_new/model/user_model.dart';

class ServiceModel {
  String? serviceId;
  String? serviceTitle;
  String? serviceDesc;
  String? serviceAmount;
  bool? serviceNegotiable;
  String? serviceStatus;
  String? latitude;
  String? longitude;
  List<ServiceImagesModel>? imagesList;

  ServiceModel({
    this.serviceId,
    this.serviceTitle,
    this.serviceDesc,
    this.serviceAmount,
    this.serviceNegotiable,
    this.serviceStatus,
    this.latitude,
    this.longitude,
    this.imagesList,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        serviceId: json['id'].toString(),
        serviceTitle: json['title'],
        serviceDesc: json['description'],
        serviceAmount: json['amount'],
        serviceNegotiable: json['is_negotiable'] == '0' ? false : true,
        serviceStatus: json['status'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        imagesList: json['images'] == null
            ? []
            : (json['images'] as List)
                .map((e) => ServiceImagesModel.fromJson(e))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': serviceId,
        'title': serviceTitle,
        'description': serviceDesc,
        'amount': serviceAmount,
        'is_negotiable': serviceNegotiable,
        'status': serviceStatus,
        'latitude': latitude,
        'longitude': longitude,
        'images': imagesList,
      };
}

class ServiceDetalModel {
  String? serviceId;
  String? userId;
  String? serviceTitle;
  String? serviceDesc;
  String? serviceAmount;
  String? serviceNegotiable;
  String? latitude;
  String? longitude;
  List<ServiceImagesModel>? imagesList;
  UserModel? user;

  ServiceDetalModel({
    this.serviceId,
    this.userId,
    this.serviceTitle,
    this.serviceDesc,
    this.serviceAmount,
    this.serviceNegotiable,
    this.latitude,
    this.longitude,
    this.imagesList,
    this.user,
  });

  factory ServiceDetalModel.fromJson(Map<String, dynamic> json) =>
      ServiceDetalModel(
        serviceId: json['id'].toString(),
        userId: json['user_id'].toString(),
        serviceTitle: json['title'],
        serviceDesc: json['description'],
        serviceAmount: json['amount'],
        serviceNegotiable: json['is_negotiable'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        imagesList: json['images'] == null
            ? []
            : (json['images'] as List)
                .map((e) => ServiceImagesModel.fromJson(e))
                .toList(),
        user: UserModel.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'id': serviceId,
        'user_id': userId,
        'title': serviceTitle,
        'description': serviceDesc,
        'amount': serviceAmount,
        'is_negotiable': serviceNegotiable,
        'latitude': latitude,
        'longitude': longitude,
        'images': imagesList,
        'user': user,
      };
}

class ServiceCompleteModel {
  String? serviceId;
  String? userId;
  String? serviceTitle;
  String? serviceDesc;
  String? serviceAmount;
  String? serviceNegotiable;
  List<ServiceImagesModel>? imagesList;
  List<OfferModel>? offersList;

  ServiceCompleteModel({
    this.serviceId,
    this.userId,
    this.serviceTitle,
    this.serviceDesc,
    this.serviceAmount,
    this.serviceNegotiable,
    this.imagesList,
    this.offersList,
  });

  factory ServiceCompleteModel.fromJson(Map<String, dynamic> json) =>
      ServiceCompleteModel(
        serviceId: json['id'].toString(),
        userId: json['user_id'].toString(),
        serviceTitle: json['title'],
        serviceDesc: json['description'],
        serviceAmount: json['amount'],
        serviceNegotiable: json['is_negotiable'],
        imagesList: json['images'] == null
            ? []
            : (json['images'] as List)
                .map((e) => ServiceImagesModel.fromJson(e))
                .toList(),
        offersList: json['chats'] == null
            ? []
            : (json['chats'] as List)
                .map((e) => OfferModel.fromJson(e))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': serviceId,
        'user_id': userId,
        'title': serviceTitle,
        'description': serviceDesc,
        'amount': serviceAmount,
        'is_negotiable': serviceNegotiable,
        'images': imagesList,
        'chats': offersList,
      };
}

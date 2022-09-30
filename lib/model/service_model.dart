import 'package:bizhub_new/model/service_images_model.dart';

class ServiceModel {
  String? serviceId;
  String? serviceTitle;
  String? serviceDesc;
  String? serviceAmount;
  String? serviceNegotiable;
  List<ServiceImagesModel>? imagesList;

  ServiceModel({
    this.serviceId,
    this.serviceTitle,
    this.serviceDesc,
    this.serviceAmount,
    this.serviceNegotiable,
    this.imagesList,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        serviceId: json['id'].toString(),
        serviceTitle: json['title'],
        serviceDesc: json['description'],
        serviceAmount: json['amount'],
        serviceNegotiable: json['is_negotiable'],
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
        'images': imagesList,
      };
}

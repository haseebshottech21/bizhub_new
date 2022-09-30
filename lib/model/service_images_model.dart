class ServiceImagesModel {
  String? id;
  String? serviceId;
  String? image;

  ServiceImagesModel({
    this.id,
    this.serviceId,
    this.image,
  });

  factory ServiceImagesModel.fromJson(Map<String, dynamic> json) =>
      ServiceImagesModel(
        id: json['id'].toString(),
        serviceId: json['service_id'].toString(),
        image: json['image'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'service_id': serviceId,
        'image': image,
      };
}

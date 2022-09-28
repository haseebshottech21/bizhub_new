class ServiceModel {
  int? serviceId;
  String? serviceTitle;
  String? serviceDesc;
  String? serviceAmount;
  String? serviceNegotiable;

  ServiceModel({
    this.serviceId,
    this.serviceTitle,
    this.serviceDesc,
    this.serviceAmount,
    this.serviceNegotiable,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        serviceId: json['id'],
        serviceTitle: json['title'],
        serviceDesc: json['description'],
        serviceAmount: json['amount'],
        serviceNegotiable: json['is_negotiable'],
      );

  Map<String, dynamic> toJson() => {
        'id': serviceId,
        'title': serviceTitle,
        'description': serviceDesc,
        'amount': serviceAmount,
        'is_negotiable': serviceNegotiable,
      };
}

import 'package:bizhub_new/model/user_model.dart';

class UserRatingModel {
  String? id;
  String? rate;
  String? review;
  UserModel? userRateBy;
  String? createAt;

  UserRatingModel({
    this.id,
    this.rate,
    this.review,
    this.userRateBy,
    this.createAt,
  });

  factory UserRatingModel.fromJson(Map<String, dynamic> json) =>
      UserRatingModel(
        id: json['id'].toString(),
        rate: json['rate'],
        review: json['review'],
        userRateBy: UserModel.fromJson(json['rate_by']),
        createAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'rate': rate,
        'review': review,
        'rate_by': userRateBy,
        'created_at': createAt,
      };
}

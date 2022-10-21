import 'package:bizhub_new/model/rating_model.dart';

class UserModel {
  int? userId;
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  String? phone;
  String? url;
  String? description;
  String? avgRating;
  String? totalReviews;
  List<UserRatingModel>? ratingList;
  // String? notificationId;

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.image,
    this.email,
    this.phone,
    this.url,
    this.description,
    this.avgRating,
    this.totalReviews,
    this.ratingList,
    // this.notificationId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        image: json['image'],
        email: json['email'],
        phone: json['phone'],
        url: json['url'],
        description: json['description'],
        avgRating: json['rating_avg_rate'].toString(),
        totalReviews: json['rating_count'].toString(),
        ratingList: json['rating'] == null
            ? []
            : (json['rating'] as List)
                .map((e) => UserRatingModel.fromJson(e))
                .toList(),
        // notificationId: json['notification_id'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'image': image,
        'email': email,
        'phone': phone,
        'url': url,
        'description': description,
        'rating_avg_rate': avgRating,
        'rating_count': totalReviews,
        'rating': ratingList,
        // 'notification_id': notificationId,
      };
}

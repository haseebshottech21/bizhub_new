class UserRatingModel {
  String? id;
  String? rate;
  String? review;

  UserRatingModel({
    this.id,
    this.rate,
    this.review,
  });

  factory UserRatingModel.fromJson(Map<String, dynamic> json) =>
      UserRatingModel(
        id: json['id'].toString(),
        rate: json['rate'],
        review: json['review'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'rate': rate,
        'review': review,
      };
}

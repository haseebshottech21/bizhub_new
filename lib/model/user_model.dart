class UserModel {
  int? userId;
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  String? phone;

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.image,
    this.email,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        image: json['image'],
        email: json['email'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'image': image,
        'email': email,
        'phone': phone,
      };
}

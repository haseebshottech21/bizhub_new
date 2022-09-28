class CategoryModel {
  int? catId;
  String? catTitle;
  String? catImage;
  String? catDesc;
  String? catActive;

  CategoryModel({
    this.catId,
    this.catTitle,
    this.catImage,
    this.catDesc,
    this.catActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        catId: json['id'],
        catTitle: json['title'],
        catImage: json['image'],
        catDesc: json['description'],
        catActive: json['is_active'],
      );

  Map<String, dynamic> toJson() => {
        'id': catId,
        'title': catTitle,
        'image': catImage,
        'description': catDesc,
        'is_active': catActive,
      };
}


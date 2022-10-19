class OnBoardModel {
  final String text;
  final String description;
  // final String subDes;
  final String image;

  OnBoardModel({
    required this.text,
    required this.description,
    // required this.subDes,
    required this.image,
  });

  OnBoardModel copyWith({
    String? text,
    String? description,
    String? subDes,
    String? image,
  }) {
    return OnBoardModel(
      text: text ?? this.text,
      description: description ?? this.description,
      // subDes: subDes ?? this.subDes,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'description': description,
      // 'subDes': subDes,
      'image': image,
    };
  }

  factory OnBoardModel.fromMap(Map<String, dynamic> map) {
    return OnBoardModel(
      text: map['text'] ?? '',
      description: map['description'] ?? '',
      // subDes: map['subDes'] ?? '',
      image: map['image'] ?? '',
    );
  }
}

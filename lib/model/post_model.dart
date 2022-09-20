class Post {
  int id;
  String postImage;
  String postTitle;
  String postPrice;
  String postStatus;

  Post({
    required this.id,
    required this.postImage,
    required this.postTitle,
    required this.postPrice,
    required this.postStatus,
  });

  Post copyWith({
    int? id,
    String? postImage,
    String? postTitle,
    String? postPrice,
    String? postStatus,
  }) {
    return Post(
      id: id ?? this.id,
      postImage: postImage ?? this.postImage,
      postTitle: postTitle ?? this.postTitle,
      postPrice: postPrice ?? this.postPrice,
      postStatus: postStatus ?? this.postStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postImage': postImage,
      'postTitle': postTitle,
      'postPrice': postPrice,
      'postStatus': postStatus,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      postImage: map['username'] ?? '',
      postTitle: map['postTitle'] ?? '',
      postPrice: map['postPrice'] ?? '',
      postStatus: map['postStatus'] ?? '',
    );
  }
}

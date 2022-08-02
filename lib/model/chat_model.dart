class Chat {
  int id;
  String username;
  String postTitle;
  String message;
  int? unReadCount;
  String lastMessageAt;

  Chat({
    required this.id,
    required this.username,
    required this.postTitle,
    required this.message,
    this.unReadCount,
    required this.lastMessageAt,
  });

  Chat copyWith({
    // String? text,
    // String? description,
    // String? subDes,
    // String? image,
    int? id,
    String? username,
    String? postTitle,
    String? message,
    int? unReadCount,
    String? lastMessageAt,
  }) {
    return Chat(
      id: id ?? this.id,
      username: username ?? this.username,
      postTitle: postTitle ?? this.postTitle,
      message: message ?? this.message,
      unReadCount: unReadCount ?? this.unReadCount,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'postTitle': postTitle,
      'message': message,
      'unReadCount': unReadCount,
      'lastMessageAt': lastMessageAt
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      postTitle: map['postTitle'] ?? '',
      message: map['message'] ?? '',
      unReadCount: map['unReadCount'] ?? '',
      lastMessageAt: map['lastMessageAt'] ?? '',
    );
  }
}

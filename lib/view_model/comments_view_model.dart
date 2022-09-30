import 'package:bizhub_new/repo/comment_repo.dart';
import 'package:flutter/foundation.dart';

class CommentViewModel extends ChangeNotifier {
  final commentRepo = CommentRepository();
}

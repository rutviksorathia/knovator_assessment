import 'package:flutter_task/models/post/post.dart';
import 'package:stacked/stacked.dart';
import 'package:dio/dio.dart';

class PostDetailsViewModel extends BaseViewModel {
  final String postId;

  PostDetailsViewModel({
    required this.postId,
  });

  Post? post;

  Future<void> fetchPost() async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
        'https://jsonplaceholder.typicode.com/posts/$postId',
      );

      post = Post.fromMap(response.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

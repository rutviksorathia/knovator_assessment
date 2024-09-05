import 'dart:convert';

import 'package:flutter_task/models/post/post.dart';
import 'package:flutter_task/ui/views/post_details/post_details_view.dart';
import 'package:stacked/stacked.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeViewModel extends BaseViewModel {
  List<Post> posts = [];
  Future<void> fetchPosts() async {
    try {
      setBusyForObject(fetchPosts, true);
      final postItems = Hive.box('postList');
      if (postItems.get("postList") != null) {
        posts = (postItems.get("postList") as List<String>)
            .map((el) => Post.fromMap(jsonDecode(el)))
            .toList();
      }

      if (posts.isEmpty) {
        Dio dio = Dio();
        var response = await dio.get(
          'https://jsonplaceholder.typicode.com/posts',
        );

        posts = (response.data as List).map((e) => Post.fromMap(e)).toList();

        postItems.put(
          "postList",
          posts.map((e) => jsonEncode(e.toMap())).toList(),
        );
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setBusyForObject(fetchPosts, false);
    }
  }

  void handlePostListItemTap(Post post) async {
    posts.firstWhere((el) => el.id == post.id).markAsRead = true;
    var result = await Get.to<bool>(() => PostDetailsView(postId: post.id));
    notifyListeners();

    final postItems = Hive.box('postList');
    postItems.put(
      "postList",
      posts.map((e) => jsonEncode(e.toMap())).toList(),
    );

    if (result == true && post.isTimerStarted) {
      post.isTimerStarted = true;
      notifyListeners();
    }
  }
}

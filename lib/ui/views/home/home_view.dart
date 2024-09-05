import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_task/models/post/post.dart';
import 'package:stacked/stacked.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.fetchPosts();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: viewModel.posts
                  .map(
                    (e) => PostListItem(
                      post: e,
                      viewModel: viewModel,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class PostListItem extends StatefulWidget {
  final Post post;
  Timer? timer;
  final HomeViewModel viewModel;

  PostListItem({
    super.key,
    required this.post,
    required this.viewModel,
    this.timer,
  });

  @override
  State<PostListItem> createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
  GlobalKey<State> key = GlobalKey();

  void handleTimerButtonTap() {
    widget.timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.post.time == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          widget.post.time--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        widget.timer?.cancel(),
        widget.viewModel.handlePostListItemTap(widget.post),
      },
      child: VisibilityDetector(
        key: key,
        onVisibilityChanged: (visibilityInfo) {
          var visiblePercentage = visibilityInfo.visibleFraction * 100;
          if (visiblePercentage == 100) {
            if (widget.timer != null || widget.post.isTimerStarted) {
              widget.timer =
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                if (widget.post.time == 0) {
                  setState(() {
                    timer.cancel();
                  });
                } else {
                  setState(() {
                    widget.post.time--;
                  });
                }
              });
            }
          } else {
            setState(() {
              widget.timer?.cancel();
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              color:
                  widget.post.markAsRead ? Colors.white : Colors.yellow.shade50,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.post.id,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: handleTimerButtonTap,
                      child: Row(
                        children: [
                          const Icon(Icons.timer),
                          Text(widget.post.time.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.post.body,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';

import 'post_details_viewmodel.dart';

class PostDetailsView extends StackedView<PostDetailsViewModel> {
  final String postId;
  const PostDetailsView({
    super.key,
    required this.postId,
  });

  @override
  PostDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PostDetailsViewModel(
        postId: postId,
      );

  @override
  void onViewModelReady(PostDetailsViewModel viewModel) {
    viewModel.fetchPost();
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    PostDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(result: true),
            child: const Icon(Icons.chevron_left)),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: viewModel.post == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      viewModel.post!.title.toUpperCase(),
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      viewModel.post!.body,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

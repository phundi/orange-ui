import 'package:flutter/material.dart';
import 'package:orange_ui/screen/create_post_screen/create_post_screen_view_model.dart';
import 'package:orange_ui/screen/create_post_screen/widget/creat_post_page.dart';
import 'package:orange_ui/screen/create_post_screen/widget/post_page.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostScreenViewModel>.reactive(
      onViewModelReady: (viewModel) {
        viewModel.init();
      },
      viewModelBuilder: () => CreatePostScreenViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: ColorRes.white,
        body: model.pageType == 0 ? CreatePostPage(model: model) : PostPage(model: model),
      ),
    );
  }
}

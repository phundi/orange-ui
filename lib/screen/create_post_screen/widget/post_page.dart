import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/screen/create_post_screen/create_post_screen_view_model.dart';
import 'package:orange_ui/screen/create_post_screen/widget/create_post_top_bar_view.dart';
import 'package:orange_ui/screen/create_post_screen/widget/image_post_view.dart';
import 'package:orange_ui/screen/create_post_screen/widget/interest_widget.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class PostPage extends StatelessWidget {
  final CreatePostScreenViewModel model;

  const PostPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        model.detectableTextFieldController.text.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: DetectableText(
                    text: model.detectableTextFieldController.text,
                    detectionRegExp: RegExp(r"\B#\w\w+"),
                    detectedStyle: const TextStyle(fontFamily: FontRes.bold, color: ColorRes.orange2, fontSize: 16),
                    basicStyle: const TextStyle(color: ColorRes.dimGrey3, fontSize: 16, fontFamily: FontRes.medium)),
              ),
        ImagePostView(model: model),
        InterestWidget(model: model)
      ],
    );
  }
}

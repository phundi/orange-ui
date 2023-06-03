import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/random_streming_screen/random_streaming_screen_view_model.dart';
import 'package:orange_ui/screen/random_streming_screen/widgets/bottom_text_field.dart';
import 'package:orange_ui/screen/random_streming_screen/widgets/comment_list_area.dart';
import 'package:orange_ui/screen/random_streming_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class RandomStreamingScreen extends StatelessWidget {
  const RandomStreamingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandomStreamingScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => RandomStreamingScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.035),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetRes.profile22),
              ),
            ),
            child: Column(
              children: [
                TopBarArea(
                  onTitleTap: model.onTitleTap,
                  onEndBtnTap: model.onEndBtnTap,
                  onDiamondTap: model.onDiamondTap,
                  onSpeakerTap: model.onSpeakerTap,
                  onCameraTap: model.onCameraTap,
                ),
                const Spacer(),
                CommentListArea(
                  commentList: model.commentList.reversed.toList(),
                  pageContext: context,
                ),
                BottomTextField(
                  commentController: model.commentController,
                  onMsgSend: model.onCommentSend,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

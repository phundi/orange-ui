import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/person_streaming_screen/person_streaming_screen_view_model.dart';
import 'package:orange_ui/screen/person_streaming_screen/widgets/bottom_text_field.dart';
import 'package:orange_ui/screen/person_streaming_screen/widgets/comment_list_area.dart';
import 'package:orange_ui/screen/person_streaming_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class PersonStreamingScreen extends StatelessWidget {
  const PersonStreamingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonStreamingScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => PersonStreamingScreenViewModel(),
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
                  onViewTap: model.onViewTap,
                  onMoreBtnTap: model.onMoreBtnTap,
                  onExitTap: model.onExitTap,
                ),
                const Spacer(),
                CommentListArea(
                  commentList: model.commentList.reversed.toList(),
                  pageContext: context,
                ),
                BottomTextField(
                  commentController: model.commentController,
                  commentFocus: model.commentFocus,
                  onMsgSend: model.onCommentSend,
                  onGiftTap: model.onGiftGtnTap,
                  onGoProTap: model.onGoPremiumTap,
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

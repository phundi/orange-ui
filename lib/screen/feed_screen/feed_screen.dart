import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/dashboard_top_bar.dart';
import 'package:orange_ui/screen/create_post_screen/create_post_screen.dart';
import 'package:orange_ui/screen/feed_screen/widget/comment_sheet.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_post_card.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_status_bar.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/style_res.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardTopBar(
            onNotificationTap: () {},
            onSearchTap: () {},
            onLivesBtnClick: () {},
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const FeedStatusBar(),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return FeedPostCard(
                        onCommentBtnClick: () {
                          Get.bottomSheet(const CommentSheet(), isScrollControlled: true);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(() => const CreatePostScreen());
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)),
              gradient: StyleRes.linearGradient),
          child: const Icon(Icons.add_rounded, color: ColorRes.white),
        ),
      ),
    );
  }
}

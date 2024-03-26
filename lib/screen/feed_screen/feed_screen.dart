import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/dashboard_top_bar.dart';
import 'package:orange_ui/screen/feed_screen/widget/comment_sheet.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_post_card.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_status_bar.dart';
import 'package:orange_ui/utils/color_res.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add_rounded,
          color: ColorRes.white,
        ),
      ),
    );
  }
}

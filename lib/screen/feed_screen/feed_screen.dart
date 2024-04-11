import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/dashboard_top_bar.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/model/social/feed.dart';
import 'package:orange_ui/screen/create_post_screen/create_post_screen.dart';
import 'package:orange_ui/screen/feed_screen/feed_screen_view_model.dart';
import 'package:orange_ui/screen/feed_screen/widget/comment_sheet.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_post_card.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_status_bar.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/style_res.dart';
import 'package:stacked/stacked.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedScreenViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      viewModelBuilder: () => FeedScreenViewModel(),
      builder: (context, model, child) => Scaffold(
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
              child: model.isLoading
                  ? Loader().lottieWidget()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const FeedStatusBar(),
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: model.posts.length,
                            itemBuilder: (context, index) {
                              Posts posts = model.posts[index];
                              return FeedPostCard(
                                  onCommentBtnClick: () {
                                    Get.bottomSheet(const CommentSheet(), isScrollControlled: true);
                                  },
                                  posts: posts);
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
            Get.bottomSheet(CreatePostScreen(),
                isScrollControlled: true,
                backgroundColor: ColorRes.white,
                barrierColor: ColorRes.white,
                enableDrag: false);
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
      ),
    );
  }
}

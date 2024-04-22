import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/common_ui.dart';
import 'package:orange_ui/common/widgets/dashboard_top_bar.dart';

import 'package:orange_ui/model/social/post/add_comment.dart';
import 'package:orange_ui/screen/feed_screen/feed_screen_view_model.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_story_bar.dart';
import 'package:orange_ui/screen/post_screen/widget/post_card.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
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
              onNotificationTap: model.onNotificationTap,
              onSearchTap: model.onSearchTap,
              onLivesBtnClick: model.onLivesBtnClick,
            ),
            Expanded(
              child: model.isLoading
                  ? CommonUI.lottieWidget()
                  : Stack(
                      children: [
                        SingleChildScrollView(
                          controller: model.scrollController,
                          child: Column(
                            children: [
                              FeedStoryBar(model: model),
                              ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: model.postList.length,
                                itemBuilder: (context, index) {
                                  Post post = model.postList[index];
                                  return PostCard(post: post, model: model);
                                },
                              ),
                            ],
                          ),
                        ),
                        model.postList.isEmpty
                            ? const Center(
                                child: Text(
                                  'No Posts',
                                  style: TextStyle(
                                      fontFamily: FontRes.medium, fontSize: 20),
                                ),
                              )
                            : Container()
                      ],
                    ),
            )
          ],
        ),
        floatingActionButton: InkWell(
          onTap: model.onCreatePost,
          child: Container(
            width: 50,
            height: 50,
            decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(cornerRadius: 30)),
                gradient: StyleRes.linearGradient),
            child: const Icon(Icons.add_rounded, color: ColorRes.white),
          ),
        ),
      ),
    );
  }
}

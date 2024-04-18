import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/social/feed.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/feed_screen/feed_screen_view_model.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_post_bottom.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_story_bar.dart';
import 'package:orange_ui/screen/feed_screen/widget/image_post.dart';
import 'package:orange_ui/screen/feed_screen/widget/text_post.dart';
import 'package:orange_ui/screen/feed_screen/widget/video_post.dart';
import 'package:orange_ui/screen/story_view_screen/story_view_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class FeedPostCard extends StatelessWidget {
  final VoidCallback onCommentBtnClick;
  final Posts? posts;
  final Function(MoreBtnValue value)? onSelected;
  final FeedScreenViewModel model;

  const FeedPostCard({
    Key? key,
    required this.onCommentBtnClick,
    this.posts,
    this.onSelected,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopAreaPost(
          userData: posts?.user,
          onSelected: onSelected,
          onProfilePictureClick: (userData) {
            Get.bottomSheet(
              StoryViewScreen(stories: [model.userData!], storyIndex: 0),
              isScrollControlled: true,
              barrierColor: ColorRes.black,
              shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 0)),
            ).then((value) {
              model.getProfile();
            });
          },
        ),
        TextPost(description: posts?.description),
        posts?.content == null || posts!.content!.isEmpty
            ? const SizedBox()
            : posts?.content?.first.contentType == 0
                ? ImagePost(content: posts?.content ?? [], model: model)
                : posts?.content?.first.contentType == 1
                    ? VideoPost(content: posts?.content ?? [])
                    : const SizedBox(),
        BottomAreaPost(
          onCommentBtnClick: onCommentBtnClick,
          posts: posts,
        ),
        const Divider(color: ColorRes.greyShade200, indent: 15, endIndent: 15),
        const SizedBox(height: 10),
      ],
    );
  }
}

class TopAreaPost extends StatelessWidget {
  final RegistrationUserData? userData;
  final Function(MoreBtnValue value)? onSelected;
  final Function(RegistrationUserData? userData) onProfilePictureClick;

  const TopAreaPost(
      {Key? key,
      required this.userData,
      required this.onSelected,
      required this.onProfilePictureClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () => onProfilePictureClick(userData),
            child: StoryProfileView(
                userData: userData,
                widthHeight: 37,
                margin: EdgeInsets.zero,
                cornerRadius: 8,
                imageCorner: 6,
                borderWidth: 2),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(userData?.fullname ?? '',
                  style: const TextStyle(
                      color: ColorRes.veryDarkGrey4,
                      fontFamily: FontRes.semiBold,
                      fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme:
                  const DividerThemeData(color: Colors.black, thickness: 10),
              dividerColor: ColorRes.black,
              iconTheme: const IconThemeData(color: Colors.white),
              textTheme: const TextTheme().apply(bodyColor: Colors.white),
            ),
            child: PopupMenuButton<MoreBtnValue>(
              onSelected: onSelected,
              itemBuilder: (context) {
                return <PopupMenuEntry<MoreBtnValue>>[
                  PopupMenuItem(
                    value: MoreBtnValue.share,
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Center(
                      child: Text(
                        S.of(context).share.capitalize ?? '',
                        style: const TextStyle(
                            fontFamily: FontRes.medium,
                            fontSize: 15,
                            color: ColorRes.dimGrey3),
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                      height: 1,
                      padding: EdgeInsets.zero,
                      child: Divider(
                          height: 1,
                          thickness: 1,
                          color: ColorRes.greyShade200)),
                  PopupMenuItem(
                    value: userData?.id == PrefService.userId
                        ? MoreBtnValue.delete
                        : MoreBtnValue.report,
                    child: Center(
                      child: Text(
                        userData?.id == PrefService.userId
                            ? S.of(context).delete
                            : S.current.report,
                        style: const TextStyle(
                            fontFamily: FontRes.medium,
                            fontSize: 15,
                            color: ColorRes.orange2),
                      ),
                    ),
                  ),
                ];
              },
              shape: SmoothRectangleBorder(
                  borderRadius:
                      SmoothBorderRadius(cornerRadius: 6, cornerSmoothing: 1),
                  side: const BorderSide(color: ColorRes.greyShade200)),
              surfaceTintColor: ColorRes.white,
              color: ColorRes.white,
              position: PopupMenuPosition.under,
              child: Image.asset(AssetRes.icHorizontalThreeDot,
                  height: 20, width: 20),
            ),
          )
        ],
      ),
    );
  }
}

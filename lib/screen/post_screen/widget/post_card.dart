import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/common_ui.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/social/post/add_comment.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/feed_screen/feed_screen_view_model.dart';
import 'package:orange_ui/screen/post_screen/widget/post_bottom_bar.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_story_bar.dart';
import 'package:orange_ui/screen/post_screen/widget/image_post.dart';
import 'package:orange_ui/screen/feed_screen/widget/text_post.dart';
import 'package:orange_ui/screen/post_screen/widget/video_post.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final FeedScreenViewModel model;
  final Function(int id)? onDeleteItem;

  const PostCard({
    Key? key,
    required this.post,
    required this.model,
    this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopAreaPost(
            userData: post.user,
            onSelected: (value) {
              model.onMoreBtnClick(value, post, onDeleteItem);
            },
            onProfilePictureClick: model.onProfilePictureClick),
        TextPost(description: post.description),
        post.content == null || post.content!.isEmpty
            ? const SizedBox()
            : post.content?.first.contentType == 0
                ? ImagePost(content: post.content ?? [], model: model)
                : post.content?.first.contentType == 1
                    ? VideoPost(post: post)
                    : const SizedBox(),
        PostBottomBar(post: post, model: model),
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
            child: InkWell(
              onTap: () {
                Get.to(() => UserDetailScreen(userData: userData));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(CommonUI.fullName(userData?.fullname),
                    style: const TextStyle(
                        color: ColorRes.veryDarkGrey4,
                        fontFamily: FontRes.semiBold,
                        fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
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

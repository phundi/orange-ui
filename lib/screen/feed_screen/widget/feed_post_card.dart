import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/common_ui.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/social/feed.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/hashtag_screen/hashtag_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeedPostCard extends StatelessWidget {
  final VoidCallback onCommentBtnClick;
  final Posts? posts;

  const FeedPostCard({Key? key, required this.onCommentBtnClick, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopAreaPost(userData: posts?.user),
        TextPost(description: posts?.description),
        posts?.content == null || posts!.content!.isEmpty
            ? const SizedBox()
            : posts?.content?.first.contentType == 0
                ? ImagePost(content: posts?.content ?? [])
                : posts?.content?.first.contentType == 1
                    ? const VideoPost()
                    : const SizedBox(),
        BottomAreaPost(
          onCommentBtnClick: onCommentBtnClick,
          commentCount: posts?.commentsCount ?? 0,
          likeCount: posts?.likesCount ?? 0,
          isLike: true,
        ),
        const Divider(color: ColorRes.greyShade200, indent: 15, endIndent: 15),
        const SizedBox(height: 10),
      ],
    );
  }
}

class TopAreaPost extends StatelessWidget {
  final RegistrationUserData? userData;

  const TopAreaPost({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: SmoothBorderRadius(cornerRadius: 7, cornerSmoothing: 1),
            child: CachedNetworkImage(
              imageUrl: CommonFun.getProfileImage(images: userData!.images),
              cacheKey: CommonFun.getProfileImage(images: userData!.images),
              width: 37,
              height: 37,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return CommonUI.profileImagePlaceHolder(name: userData?.fullname, heightWeight: 37);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(userData?.fullname ?? '',
                  style: const TextStyle(color: ColorRes.veryDarkGrey4, fontFamily: FontRes.semiBold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(color: Colors.black, thickness: 10),
              dividerColor: ColorRes.black,
              iconTheme: const IconThemeData(color: Colors.white),
              textTheme: const TextTheme().apply(bodyColor: Colors.white),
            ),
            child: PopupMenuButton(
              onSelected: (value) {},
              itemBuilder: (context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 'Share',
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Center(
                      child: Text(
                        S.of(context).share.capitalize ?? '',
                        style: const TextStyle(fontFamily: FontRes.medium, fontSize: 15, color: ColorRes.dimGrey3),
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                      height: 1,
                      padding: EdgeInsets.zero,
                      child: Divider(height: 1, thickness: 1, color: ColorRes.greyShade200)),
                  PopupMenuItem(
                    value: userData?.id == PrefService.userId ? 'Delete' : 'Report',
                    child: Center(
                      child: Text(
                        userData?.id == PrefService.userId ? S.of(context).delete : S.current.report,
                        style: const TextStyle(fontFamily: FontRes.medium, fontSize: 15, color: ColorRes.orange2),
                      ),
                    ),
                  ),
                ];
              },
              shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 6, cornerSmoothing: 1),
                  side: const BorderSide(color: ColorRes.greyShade200)),
              surfaceTintColor: ColorRes.white,
              color: ColorRes.white,
              position: PopupMenuPosition.under,
              child: Image.asset(AssetRes.icHorizontalThreeDot, height: 20, width: 20),
            ),
          )
        ],
      ),
    );
  }
}

class TextPost extends StatelessWidget {
  final String? description;

  const TextPost({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: description != null,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
        child: DetectableText(
          text: description ?? '',
          detectionRegExp: RegExp(r"\B#\w\w+"),
          onTap: (p0) {
            Get.to(() => HashtagScreen(
                  hashtagName: p0,
                ));
          },
          detectedStyle: const TextStyle(fontFamily: FontRes.bold, color: ColorRes.orange2, fontSize: 16),
          basicStyle: const TextStyle(color: ColorRes.dimGrey3, fontSize: 16, fontFamily: FontRes.medium),
        ),
      ),
    );
  }
}

class ImagePost extends StatelessWidget {
  final List<Content> content;

  const ImagePost({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child:

          /// For Single sImage
          content.length == 1
              ? CachedNetworkImage(
                  imageUrl: '${ConstRes.aImageBaseUrl}${content.first.content}',
                  fit: BoxFit.cover,
                  height: null,
                  width: double.infinity,
                  errorWidget: (context, url, error) => CommonUI.postPlaceHolder(),
                )
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    /// For Multiple Image
                    SizedBox(
                      height: 390,
                      child: PageView.builder(
                        controller: PageController(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                              imageUrl: '${ConstRes.aImageBaseUrl}${content.first.content}',
                              fit: BoxFit.cover,
                              height: null,
                              width: double.infinity);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SmoothPageIndicator(
                          controller: PageController(), // PageController
                          effect: CustomizableEffect(
                              dotDecoration:
                                  DotDecoration(width: 31, height: 2, color: ColorRes.white.withOpacity(0.3)),
                              activeDotDecoration: const DotDecoration(
                                  width: 31, height: 2, color: ColorRes.white)), // your preferred effect
                          onDotClicked: (index) {}, count: 5,
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}

class VideoPost extends StatelessWidget {
  const VideoPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(AssetRes.icImage),
          Container(
              height: 53,
              width: 53,
              decoration: BoxDecoration(color: ColorRes.black.withOpacity(0.4), shape: BoxShape.circle),
              padding: const EdgeInsets.all(15),
              child: Image.asset(AssetRes.icPlay, alignment: Alignment.centerRight)),
          Positioned(
            bottom: 0,
            left: 0,
            child: FittedBox(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: ColorRes.white),
                child: Row(
                  children: [
                    Image.asset(AssetRes.icEye, width: 15, height: 15),
                    const SizedBox(width: 10),
                    const Text(
                      '50.6K',
                      style: TextStyle(fontFamily: FontRes.medium, color: ColorRes.veryDarkGrey4, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomAreaPost extends StatelessWidget {
  final VoidCallback onCommentBtnClick;
  final int commentCount;
  final int likeCount;
  final bool isLike;

  const BottomAreaPost(
      {Key? key,
      required this.onCommentBtnClick,
      required this.commentCount,
      required this.likeCount,
      required this.isLike})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
      child: Row(
        children: [
          InkWell(
            onTap: onCommentBtnClick,
            child: Row(
              children: [
                Image.asset(
                  AssetRes.icComment,
                  height: 22,
                  width: 22,
                ),
                Text(
                  '  $commentCount',
                  style: const TextStyle(
                      color: ColorRes.veryDarkGrey4, fontFamily: FontRes.medium, letterSpacing: 0.5, fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(height: 20, width: 1, color: ColorRes.lightGrey),
          const SizedBox(width: 15),
          Image.asset(AssetRes.icFillFav, height: 22, width: 22),
          Text(
            '  ${NumberFormat.compact().format(likeCount)}  ',
            style: const TextStyle(
                color: ColorRes.veryDarkGrey4, fontFamily: FontRes.medium, letterSpacing: 0.5, fontSize: 15),
          ),
          const SizedBox(width: 5),
          Container(height: 20, width: 1, color: ColorRes.lightGrey),
          const SizedBox(width: 10),
          Image.asset(AssetRes.icPostShare, height: 22, width: 22),
          const Spacer(),
          const Text(
            '15 mins',
            style: TextStyle(fontFamily: FontRes.medium, fontSize: 12, color: ColorRes.dimGrey3),
          )
        ],
      ),
    );
  }
}

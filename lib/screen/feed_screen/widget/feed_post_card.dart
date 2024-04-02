import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/hashtag_screen/hashtag_screen.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class FeedPostCard extends StatelessWidget {
  final VoidCallback onCommentBtnClick;

  const FeedPostCard({Key? key, required this.onCommentBtnClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopAreaPost(),
        const TextPost(),
        const VideoPost(),
        BottomAreaPost(onCommentBtnClick: onCommentBtnClick),
        const Divider(color: ColorRes.greyShade200, indent: 15, endIndent: 15),
        const SizedBox(height: 10),
      ],
    );
  }
}

class TopAreaPost extends StatelessWidget {
  const TopAreaPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: SmoothBorderRadius(cornerRadius: 7, cornerSmoothing: 1),
            child: Image.asset(AssetRes.icImage, width: 37, height: 37, fit: BoxFit.cover),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '@jessi_robinson',
                style: TextStyle(color: ColorRes.veryDarkGrey4, fontFamily: FontRes.semiBold, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
                    value: 'Delete',
                    child: Center(
                      child: Text(
                        S.of(context).delete,
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
  const TextPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
      child: DetectableText(
        text:
            'If you look at what you have in #life, you\'ll always have more. If you look at what y ou don\'t have in life, you\'ll never have #enough',
        detectionRegExp: RegExp(r"\B#\w\w+"),
        onTap: (p0) {
          Get.to(() => HashtagScreen(
                hashtagName: p0,
              ));
        },
        detectedStyle: const TextStyle(fontFamily: FontRes.bold, color: ColorRes.orange2, fontSize: 16),
        basicStyle: const TextStyle(color: ColorRes.dimGrey3, fontSize: 16, fontFamily: FontRes.medium),
      ),
    );
  }
}

class ImagePost extends StatelessWidget {
  const ImagePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Image.asset(
        AssetRes.icImage,
        width: double.infinity,
        fit: BoxFit.cover,
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

  const BottomAreaPost({Key? key, required this.onCommentBtnClick}) : super(key: key);

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
                const Text(
                  '  253',
                  style: TextStyle(
                      color: ColorRes.veryDarkGrey4, fontFamily: FontRes.medium, letterSpacing: 0.5, fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: 20,
            width: 1,
            color: ColorRes.lightGrey,
          ),
          const SizedBox(
            width: 15,
          ),
          Image.asset(
            AssetRes.icFillFav,
            height: 22,
            width: 22,
          ),
          const Text(
            '  2.5K  ',
            style: TextStyle(
                color: ColorRes.veryDarkGrey4, fontFamily: FontRes.medium, letterSpacing: 0.5, fontSize: 15),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            height: 20,
            width: 1,
            color: ColorRes.lightGrey,
          ),
          const SizedBox(
            width: 10,
          ),
          Image.asset(
            AssetRes.icPostShare,
            height: 22,
            width: 22,
          ),
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

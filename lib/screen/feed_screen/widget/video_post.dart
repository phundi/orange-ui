import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/common_ui.dart';
import 'package:orange_ui/model/social/post/add_comment.dart';
import 'package:orange_ui/screen/video_preview_screen/video_preview_screen.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class VideoPost extends StatelessWidget {
  final List<Content> content;

  const VideoPost({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => VideoPreviewScreen(videoUrl: content.first.content));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: Get.height / 1.7),
              child: CachedNetworkImage(
                  imageUrl:
                      '${ConstRes.aImageBaseUrl}${content.first.thumbnail}',
                  cacheKey:
                      '${ConstRes.aImageBaseUrl}${content.first.thumbnail}',
                  errorWidget: (context, url, error) =>
                      CommonUI.postPlaceHolder(),
                  width: double.infinity,
                  fit: BoxFit.cover),
            ),
            Container(
                height: 53,
                width: 53,
                decoration: BoxDecoration(
                    color: ColorRes.black.withOpacity(0.4),
                    shape: BoxShape.circle),
                padding: const EdgeInsets.all(15),
                child: Image.asset(AssetRes.icPlay,
                    alignment: Alignment.centerRight)),
            Positioned(
              bottom: 0,
              left: 0,
              child: InkWell(
                onTap: () {},
                child: FittedBox(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorRes.white),
                    child: Row(
                      children: [
                        Image.asset(AssetRes.icEye, width: 15, height: 15),
                        const SizedBox(width: 10),
                        const Text(
                          '50.6K',
                          style: TextStyle(
                              fontFamily: FontRes.medium,
                              color: ColorRes.veryDarkGrey4,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

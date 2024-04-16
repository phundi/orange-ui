import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/common_ui.dart';
import 'package:orange_ui/screen/camera_screen/camera_screen.dart';
import 'package:orange_ui/screen/feed_screen/feed_screen_view_model.dart';
import 'package:orange_ui/screen/story_view_screen/story_view_screen.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class FeedStatusBar extends StatelessWidget {
  final FeedScreenViewModel model;

  const FeedStatusBar({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.to(() => const CameraScreen());
          },
          child: Container(
            width: 70,
            height: 80,
            margin: const EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 5),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipRRect(
                  borderRadius: SmoothBorderRadius(cornerRadius: 15, cornerSmoothing: 1),
                  child: CachedNetworkImage(
                    imageUrl: CommonFun.getProfileImage(images: model.users?.images),
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return CommonUI.profileImagePlaceHolder(name: model.users?.fullname, borderRadius: 15);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Image.asset(AssetRes.add, height: 30, width: 30),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 90,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: ListView.builder(
              itemCount: model.stories.length,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      StoryViewScreen(stories: model.stories, index: index),
                      isScrollControlled: true,
                      barrierColor: ColorRes.black,
                      shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 0)),
                    ).then((value) {
                      model.fetchStories();
                    });
                  },
                  child: SizedBox(
                    width: 80,
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: ShapeDecoration(
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(cornerRadius: 15, cornerSmoothing: 1),
                            ),
                            gradient: LinearGradient(
                                colors: CommonFun.isAllStoryShown(model.stories[index].stories ?? [])
                                    ? [ColorRes.dimGrey, ColorRes.dimGrey]
                                    : [ColorRes.lightOrange1, ColorRes.darkOrange],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: Container(
                            width: 66,
                            height: 66,
                            margin: const EdgeInsets.all(2.5),
                            decoration: ShapeDecoration(
                              color: ColorRes.white,
                              shape: SmoothRectangleBorder(
                                  side: const BorderSide(color: ColorRes.white),
                                  borderRadius: SmoothBorderRadius(cornerRadius: 13, cornerSmoothing: 1)),
                            ),
                            child: ClipRRect(
                              borderRadius: SmoothBorderRadius(cornerRadius: 13, cornerSmoothing: 1),
                              child: Image.asset(AssetRes.icImage, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Text(
                          model.stories[index].fullname ?? '',
                          style: const TextStyle(color: ColorRes.dimGrey3, fontSize: 13, fontFamily: FontRes.semiBold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

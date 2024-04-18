import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/common_ui.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/camera_screen/camera_screen.dart';
import 'package:orange_ui/screen/feed_screen/feed_screen_view_model.dart';
import 'package:orange_ui/screen/story_view_screen/story_view_screen.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:orange_ui/utils/style_res.dart';

class FeedStoryBar extends StatelessWidget {
  final FeedScreenViewModel model;

  const FeedStoryBar({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyStoryBox(model: model),
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
                RegistrationUserData userData = model.stories[index];
                return InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      StoryViewScreen(
                          stories: model.stories, storyIndex: index),
                      isScrollControlled: true,
                      barrierColor: ColorRes.black,
                      shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(cornerRadius: 0)),
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
                        StoryProfileView(
                          userData: userData,
                          borderWidth: 2.5,
                        ),
                        Text(
                          model.stories[index].fullname ?? '',
                          style: const TextStyle(
                              color: ColorRes.dimGrey3,
                              fontSize: 13,
                              fontFamily: FontRes.semiBold),
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

class MyStoryBox extends StatelessWidget {
  final FeedScreenViewModel model;

  const MyStoryBox({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isStoryAvailable = (model.userData?.story ?? []).isNotEmpty;
    return InkWell(
      onTap: () {
        if (isStoryAvailable) {
          Get.bottomSheet(
            StoryViewScreen(stories: [model.userData!], storyIndex: 0),
            isScrollControlled: true,
            barrierColor: ColorRes.black,
            shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(cornerRadius: 0)),
          ).then((value) {
            model.getProfile();
          });
        } else {
          Get.to(() => CameraScreen(cameras: model.cameras))?.then((value) {
            model.getProfile();
          });
        }
      },
      child: Container(
        height: 90,
        width: 80,
        margin: const EdgeInsets.only(top: 15, bottom: 15, left: 10),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            StoryProfileView(userData: model.userData, borderWidth: 2.5),
            Positioned(
              bottom: 6,
              child: InkWell(
                onTap: () {
                  Get.to(() => CameraScreen(cameras: model.cameras))
                      ?.then((value) {
                    model.getProfile();
                  });
                },
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Image.asset(AssetRes.add, height: 30, width: 30)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StoryProfileView extends StatelessWidget {
  final RegistrationUserData? userData;
  final double? widthHeight;
  final double? cornerRadius;
  final double imageCorner;
  final EdgeInsets? margin;
  final double borderWidth;
  const StoryProfileView(
      {Key? key,
      required this.userData,
      this.widthHeight = 70,
      this.cornerRadius,
      this.margin,
      this.imageCorner = 13,
      required this.borderWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isStoryAvailable = (userData?.story ?? []).isNotEmpty;
    return Container(
      width: widthHeight,
      height: widthHeight,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 5),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
              cornerRadius: cornerRadius ?? 15.5, cornerSmoothing: 1),
        ),
        gradient: isStoryAvailable
            ? (userData!.isAllStoryShown()
                ? StyleRes.linearDimGrey
                : StyleRes.linearGradient)
            : null,
      ),
      child: Container(
        margin: EdgeInsets.all(isStoryAvailable ? borderWidth : 0),
        decoration: ShapeDecoration(
          color: ColorRes.white,
          shape: SmoothRectangleBorder(
              side: const BorderSide(color: ColorRes.white, width: 1),
              borderRadius: SmoothBorderRadius(
                  cornerRadius: imageCorner, cornerSmoothing: 1)),
        ),
        child: ClipRRect(
          borderRadius: SmoothBorderRadius(
              cornerRadius: imageCorner - 1, cornerSmoothing: 1),
          child: CachedNetworkImage(
            imageUrl: CommonFun.getProfileImage(images: userData?.images),
            cacheKey: CommonFun.getProfileImage(images: userData?.images),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorWidget: (context, url, error) {
              return CommonUI.profileImagePlaceHolder(
                  name: userData?.fullname,
                  heightWeight: 66,
                  borderRadius: imageCorner - 1);
            },
          ),
        ),
      ),
    );
  }
}

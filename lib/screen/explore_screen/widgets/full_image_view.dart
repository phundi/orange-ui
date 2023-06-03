import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/gradient_widget.dart';
import 'package:orange_ui/common/widgets/live_icon.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class FullImageView extends StatelessWidget {
  final List<String> imageList;
  final PageController pageController;
  final VoidCallback onLiveBtnTap;
  final VoidCallback onImageTap;
  final String fullName;
  final int age;
  final String address;
  final String bioText;

  const FullImageView({
    Key? key,
    required this.imageList,
    required this.pageController,
    required this.onLiveBtnTap,
    required this.onImageTap,
    required this.fullName,
    required this.age,
    required this.address,
    required this.bioText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height - 264,
      margin: const EdgeInsets.symmetric(horizontal: 21),
      child: InkWell(
        onTap: onImageTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: PageView.builder(
                controller: pageController,
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return FractionallySizedBox(
                    widthFactor: 1 / pageController.viewportFraction,
                    child: Container(
                      width: Get.width,
                      height: Get.height - 256,
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(imageList[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: Get.height - 256,
              width: Get.width,
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  topStoryLine(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: Row(
                      children: [
                        socialIcon(AssetRes.instaLogo, 15),
                        socialIcon(AssetRes.facebookLogo, 21.0),
                        socialIcon(AssetRes.youtubeLogo, 20.16),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: InkWell(
                              onTap: onLiveBtnTap,
                              child: Container(
                                height: 35,
                                width: 113,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: ColorRes.black.withOpacity(0.33),
                                ),
                                child: Row(
                                  children: const [
                                    LiveIcon(),
                                    Text(
                                      " ${AppRes.liveCap}",
                                      style: TextStyle(
                                        color: ColorRes.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      " ${AppRes.nowCap}",
                                      style: TextStyle(
                                        color: ColorRes.white,
                                        fontFamily: "gilroy_bold",
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 7),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.fromLTRB(13, 9, 13, 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorRes.black.withOpacity(0.33),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    fullName,
                                    style: const TextStyle(
                                      color: ColorRes.white,
                                      fontSize: 20,
                                      //fontFamily: 'gilroy_bold',
                                      fontFamily: "gilroy_bold",
                                    ),
                                  ),
                                  Text(
                                    " $age",
                                    style: const TextStyle(
                                      color: ColorRes.white,
                                      fontSize: 20,
                                      fontFamily: "gilroy",
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 9,
                                        width: 9,
                                        color: ColorRes.white,
                                      ),
                                      Image.asset(
                                        AssetRes.tickMark,
                                        height: 17.5,
                                        width: 18.33,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  GradientWidget(
                                    child: Image.asset(
                                      AssetRes.locationPin,
                                      height: 13.5,
                                      width: 10.5,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    address,
                                    style: const TextStyle(
                                      color: ColorRes.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6.25),
                              Text(
                                bioText,
                                style: const TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topStoryLine() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 31),
      height: 3,
      width: Get.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 3),
            height: 2.7,
            width:
                Get.width / imageList.length - (106 / (imageList.length)) - 3,
            decoration: BoxDecoration(
              color: pageController.page!.round() == index
                  ? ColorRes.white
                  : ColorRes.white.withOpacity(0.30),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }

  Widget socialIcon(String icon, double size) {
    return Container(
      height: 29,
      width: 29,
      margin: const EdgeInsets.only(right: 7),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorRes.white,
      ),
      child: Center(
        child: Image.asset(icon, height: size, width: size),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/gradient_widget.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class FullImageView extends StatelessWidget {
  final List<String> imageList;
  final PageController pageController;
  final String fullName;
  final int age;
  final String address;
  final String bioText;

  const FullImageView({
    Key? key,
    required this.imageList,
    required this.pageController,
    required this.fullName,
    required this.age,
    required this.address,
    required this.bioText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height / 1.65,
      margin: const EdgeInsets.symmetric(horizontal: 36),
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              return FractionallySizedBox(
                widthFactor: 1 / pageController.viewportFraction,
                child: Container(
                  width: Get.width,
                  height: Get.height / 1.65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(imageList[index]),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            width: Get.width,
            height: Get.height / 1.65,
            child: Column(
              children: [
                const SizedBox(height: 14),
                topStoryLine(),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: Row(
                    children: [
                      socialIcon(AssetRes.instaLogo, 13.58),
                      socialIcon(AssetRes.facebookLogo, 18.0),
                      socialIcon(AssetRes.youtubeLogo, 18.26),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 9, right: 9, bottom: 9, top: 7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.15, horizontal: 11.77),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorRes.black.withOpacity(0.33),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: fullName,
                                    style: const TextStyle(
                                      color: ColorRes.white,
                                      fontSize: 18,
                                      //fontFamily: 'gilroy_bold',
                                      fontFamily: "gilroy_bold",
                                    ),
                                  ),
                                  TextSpan(
                                    text: " $age",
                                    style: const TextStyle(
                                      color: ColorRes.white,
                                      fontSize: 18,
                                      fontFamily: "gilroy",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GradientWidget(
                                  child: Image.asset(
                                    AssetRes.locationPin,
                                    height: 12.23,
                                    width: 9.51,
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
                            const SizedBox(height: 2),
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
    );
  }

  Widget topStoryLine() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
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
                Get.width / imageList.length - (128 / (imageList.length)) - 3,
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
      height: 27,
      width: 27,
      margin: const EdgeInsets.only(right: 6.34),
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

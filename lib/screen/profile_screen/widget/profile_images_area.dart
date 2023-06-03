import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/gradient_widget.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class ProfileImageArea extends StatelessWidget {
  final List<String> imageList;
  final PageController pageController;
  final VoidCallback onEditProfileTap;
  final VoidCallback onImageTap;
  final VoidCallback onMoreBtnTap;
  final String fullName;
  final int age;
  final String address;
  final String bioText;

  const ProfileImageArea({
    Key? key,
    required this.imageList,
    required this.pageController,
    required this.onEditProfileTap,
    required this.onMoreBtnTap,
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
      height: Get.height - 200,
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
            Column(
              children: [
                const SizedBox(height: 14),
                topStoryLine(),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      socialIcon(AssetRes.instaLogo, 15),
                      socialIcon(AssetRes.facebookLogo, 21.0),
                      socialIcon(AssetRes.youtubeLogo, 20.16),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 0, top: 7),
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
                            const SizedBox(height: 7),
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: onEditProfileTap,
                          borderRadius: BorderRadius.circular(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorRes.black.withOpacity(0.33),
                                ),
                                child: Center(
                                  child: Text(
                                    AppRes.editProfile,
                                    style: TextStyle(
                                      color: ColorRes.white.withOpacity(0.86),
                                      letterSpacing: 0.8,
                                      fontFamily: 'gilroy_bold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: onMoreBtnTap,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                            child: Container(
                              height: 48,
                              width: 56,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorRes.black.withOpacity(0.33),
                              ),
                              child: Center(
                                child: Image.asset(
                                  AssetRes.moreHorizontal,
                                  color: ColorRes.white,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
              ],
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
            height: 3,
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/gradient_widget.dart';
import 'package:orange_ui/common/widgets/live_icon.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class ImageSelectionArea extends StatelessWidget {
  final int selectedImgIndex;
  final List<String> imageList;
  final VoidCallback onJoinBtnTap;
  final bool like;
  final Function(int index) onImgSelect;
  final VoidCallback onMoreInfoTap;
  final VoidCallback onLikeBtnTap;

  const ImageSelectionArea({
    Key? key,
    required this.selectedImgIndex,
    required this.imageList,
    required this.like,
    required this.onJoinBtnTap,
    required this.onImgSelect,
    required this.onMoreInfoTap,
    required this.onLikeBtnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 101,
      width: Get.width,
      child: Column(
        children: [
          joinBtnChip(),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onLikeBtnTap,
            child: Container(
              height: 76,
              width: 76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorRes.white.withOpacity(0.30),
              ),
              child: Center(
                child: Container(
                  height: 66,
                  width: 66,
                  padding: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorRes.white.withOpacity(0.30),
                  ),
                  child: like
                      ? const GradientWidget(
                          child: Icon(
                            Icons.favorite,
                            color: ColorRes.white,
                            size: 40,
                          ),
                        )
                      : const Icon(
                          Icons.favorite,
                          color: ColorRes.white,
                          size: 40,
                        ),
                  //Image.asset(AssetRes.like, height: 30.23, width: 33),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          imageListArea(),
          const SizedBox(height: 20),
          bottomMoreBtn(),
        ],
      ),
    );
  }

  Widget joinBtnChip() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
        child: InkWell(
          onTap: onJoinBtnTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 35,
            width: 205,
            padding: const EdgeInsets.fromLTRB(4, 2, 2, 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: ColorRes.black.withOpacity(0.33),
            ),
            child: Row(
              children: [
                const LiveIcon(),
                const SizedBox(width: 3),
                const Text(
                  AppRes.liveCap,
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  " ${AppRes.nowCap}",
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 12,
                    fontFamily: "gilroy_bold",
                  ),
                ),
                const Spacer(),
                Container(
                  height: 31,
                  width: 95,
                  decoration: BoxDecoration(
                    color: ColorRes.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      AppRes.join,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 12,
                        fontFamily: "gilroy_bold",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageListArea() {
    return SizedBox(
      height: 58,
      child: ListView.builder(
        itemCount: imageList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              onImgSelect(index);
            },
            child: Container(
              height: 58,
              width: 58,
              margin: EdgeInsets.only(
                  right: index != (imageList.length - 1) ? 8.33 : 0),
              decoration: BoxDecoration(
                border: selectedImgIndex == index
                    ? Border.all(
                        color: ColorRes.white.withOpacity(0.80),
                        width: 2,
                      )
                    : null,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imageList[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bottomMoreBtn() {
    return SizedBox(
      height: 57,
      width: Get.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                child: Container(
                  width: Get.width,
                  height: 42,
                  decoration: BoxDecoration(
                    color: ColorRes.black.withOpacity(0.33),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onMoreInfoTap,
            child: Container(
              padding: const EdgeInsets.fromLTRB(21, 10, 21, 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorRes.lightOrange1,
                    ColorRes.darkOrange,
                  ],
                ),
              ),
              child: Text(
                AppRes.moreInfo,
                style: TextStyle(
                  color: ColorRes.white.withOpacity(0.80),
                  fontSize: 11,
                  fontFamily: "gilroy_bold",
                  letterSpacing: 0.65,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

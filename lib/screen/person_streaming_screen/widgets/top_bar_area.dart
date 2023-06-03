import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class TopBarArea extends StatelessWidget {
  final VoidCallback onViewTap;
  final VoidCallback onExitTap;
  final VoidCallback onMoreBtnTap;

  const TopBarArea({
    Key? key,
    required this.onViewTap,
    required this.onExitTap,
    required this.onMoreBtnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 38),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 60,
              width: Get.width,
              padding: const EdgeInsets.fromLTRB(13, 8, 23, 9),
              decoration: BoxDecoration(
                color: ColorRes.black4.withOpacity(0.33),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      AssetRes.profile13,
                      height: 37,
                      width: 37,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text(
                            "Mimi Brown",
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 16,
                              fontFamily: 'gilroy_bold',
                            ),
                          ),
                          const Text(
                            " 24",
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                color: ColorRes.white,
                              ),
                              Image.asset(
                                AssetRes.tickMark,
                                height: 18,
                                width: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        "Las Vegas, USA",
                        style: TextStyle(
                          color: ColorRes.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: onMoreBtnTap,
                    child: Image.asset(
                      AssetRes.moreHorizontal,
                      height: 10,
                      width: 25,
                      fit: BoxFit.cover,
                      color: ColorRes.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: InkWell(
              onTap: onViewTap,
              child: Container(
                height: 39,
                width: Get.width,
                padding: const EdgeInsets.fromLTRB(13, 4, 4, 4),
                decoration: BoxDecoration(
                  color: ColorRes.black4.withOpacity(0.33),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AssetRes.themeLabelWhite,
                          height: 20,
                          width: 69,
                        ),
                        const SizedBox(width: 2),
                        const Text(
                          AppRes.live,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: onExitTap,
                          child: Row(
                            children: [
                              Image.asset(
                                AssetRes.exit,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 3),
                              const Text(
                                AppRes.exit,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 13),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        "15k+ ${AppRes.viewers}",
                        style: TextStyle(
                          color: ColorRes.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

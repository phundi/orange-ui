import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class CenterAreaLiveStreamDashBoard extends StatelessWidget {
  final VoidCallback onRedeemTap;
  final bool eligible;
  final VoidCallback onEligibleTap;
  final VoidCallback onHistoryBtnTap;
  final VoidCallback onRedeemBtnTap;
  final VoidCallback onApplyBtnTap;

  const CenterAreaLiveStreamDashBoard({
    Key? key,
    required this.onRedeemTap,
    required this.eligible,
    required this.onEligibleTap,
    required this.onHistoryBtnTap,
    required this.onRedeemBtnTap,
    required this.onApplyBtnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 9),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 54,
                width: Get.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(AssetRes.map1),
                ),
              ),
              Container(
                height: 54,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.darkGrey5.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(
                height: 54,
                width: Get.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaY: 15, sigmaX: 15, tileMode: TileMode.mirror),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            AppRes.getAccess,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'gilroy_bold',
                              color: ColorRes.lightGrey4,
                            ),
                          ),
                          InkWell(
                            onTap: onApplyBtnTap,
                            child: Container(
                              height: 36.17,
                              width: 112,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ColorRes.lightpink1.withOpacity(0.15)),
                              child: const Center(
                                child: Text(
                                  AppRes.apply,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ColorRes.red1,
                                    fontFamily: 'gilroy_semibold',
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              SizedBox(
                height: 54,
                width: Get.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(AssetRes.map1),
                ),
              ),
              Container(
                height: 54,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.darkGrey5.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(
                height: 54,
                width: Get.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13, right: 3),
                      child: Row(
                        children: [
                          Image.asset(
                            AssetRes.sun,
                            color: ColorRes.lightOrange1,
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(width: 13),
                          const Text(
                            AppRes.eligibility,
                            style: TextStyle(
                                fontSize: 15, color: ColorRes.lightGrey4),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: onEligibleTap,
                            child: Container(
                              height: 36.17,
                              width: 115,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: eligible
                                    ? ColorRes.red7.withOpacity(0.20)
                                    : ColorRes.lightgreen1.withOpacity(0.20),
                              ),
                              child: Center(
                                child: Text(
                                  eligible
                                      ? AppRes.notEligible
                                      : AppRes.eligible,
                                  style: TextStyle(
                                    color: eligible
                                        ? ColorRes.red8
                                        : ColorRes.green2,
                                    fontSize: 12,
                                    fontFamily: 'gilroy_semibold',
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              SizedBox(
                width: Get.width,
                height: 202,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(AssetRes.map2),
                ),
              ),
              Container(
                height: 202,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.darkGrey5.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(
                height: 202,
                width: Get.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 19, top: 18, right: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                AppRes.wallet,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: ColorRes.lightGrey5,
                                  letterSpacing: 2,
                                  fontFamily: "gilroy_semibold",
                                ),
                              ),
                              const Spacer(),
                              Image.asset(
                                AssetRes.themeLabel,
                                height: 23,
                                width: 76,
                              ),
                              const Text(
                                AppRes.liveCAp,
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            AppRes.num,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'gilroy_bold',
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 17),
                          Row(
                            children: [
                              Container(
                                height: 7,
                                width: Get.width / 2 - 29,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(20)),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      ColorRes.darkOrange,
                                      ColorRes.lightOrange1,
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 7,
                                width: Get.width / 2 - 29,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(20)),
                                  color: ColorRes.grey31,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                AppRes.threshold,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: ColorRes.lightGrey4,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 19),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: onRedeemTap,
                                child: Container(
                                  height: 41,
                                  width: 141,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        ColorRes.lightOrange1,
                                        ColorRes.darkOrange,
                                      ],
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      AppRes.redeemCap,
                                      style: TextStyle(
                                        color: ColorRes.white,
                                        fontSize: 12,
                                        fontFamily: 'gilroy_semibold',
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Stack(
            children: [
              SizedBox(
                width: Get.width,
                height: 138,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(AssetRes.map2),
                ),
              ),
              Container(
                height: 138,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.darkGrey5.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(
                height: 138,
                width: Get.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 19, top: 18, right: 13, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                AppRes.totalStream,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: ColorRes.lightGrey5,
                                  fontFamily: "gilroy_semibold",
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Text(
                                AppRes.totalCollection,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: ColorRes.lightGrey5,
                                  fontFamily: "gilroy_semibold",
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                AppRes.num1,
                                style: TextStyle(
                                  color: ColorRes.lightGrey4,
                                  letterSpacing: 3,
                                  fontSize: 19,
                                  fontFamily: 'gilroy_bold',
                                ),
                              ),
                              Text(
                                AppRes.num2,
                                style: TextStyle(
                                  color: ColorRes.lightGrey4,
                                  letterSpacing: 3,
                                  fontSize: 19,
                                  fontFamily: 'gilroy_bold',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 13),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: onHistoryBtnTap,
                                child: Container(
                                  height: 37.8,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color:
                                        ColorRes.lightGrey6.withOpacity(0.20),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      AppRes.history,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ColorRes.darkGrey9,
                                        fontFamily: "gilroy_semibold",
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: onRedeemBtnTap,
                                child: Container(
                                  // height: 38,
                                  //width: 150,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 11),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color:
                                        ColorRes.lightGrey6.withOpacity(0.20),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      AppRes.redeemRequests,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ColorRes.darkGrey9,
                                        fontFamily: "gilroy_semibold",
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

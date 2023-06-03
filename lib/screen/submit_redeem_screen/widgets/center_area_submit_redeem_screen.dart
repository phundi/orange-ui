import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class CenterAreaSubmitRedeemScreen extends StatelessWidget {
  const CenterAreaSubmitRedeemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 156,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorRes.lightGrey2,
                    image: const DecorationImage(
                        image: AssetImage(AssetRes.map3))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 19, left: 18, right: 17, bottom: 14),
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
                                  fontFamily: 'gilroy_semibold',
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
                          const SizedBox(height: 12),
                          const Text(
                            AppRes.num3,
                            style: TextStyle(
                                color: ColorRes.lightGrey4,
                                letterSpacing: 4,
                                fontSize: 22,
                                fontFamily: 'gilroy_bold'),
                          ),
                          const SizedBox(height: 17),
                          Container(
                            height: 7,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorRes.lightOrange1,
                                  ColorRes.darkOrange,
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                AppRes.threshold,
                                style: TextStyle(
                                  color: ColorRes.lightGrey4,
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                '1 Diamond = \$0.001',
                                style: TextStyle(
                                  color: ColorRes.lightGrey4,
                                  fontSize: 11,
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
              const SizedBox(height: 21),
              const Text(
                'PAYMENT GATEWAY',
                style: TextStyle(
                  color: ColorRes.darkGrey3,
                  fontSize: 15,
                  fontFamily: 'gilroy_extra_bold',
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: Get.width,
                height: 48,
                padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.lightGrey2,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'PayPal',
                        style: TextStyle(
                          color: ColorRes.dimGrey3,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        height: 37,
                        width: 37,
                        padding: const EdgeInsets.only(right: 3),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetRes.backButton),
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            AssetRes.downArrow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'ACCOUNT DETAILS',
                style: TextStyle(
                  color: ColorRes.darkGrey3,
                  fontSize: 15,
                  fontFamily: 'gilroy_extra_bold',
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 67,
                width: Get.width,
                padding: const EdgeInsets.only(left: 12, top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.lightGrey2,
                ),
                child: const TextField(
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  decoration: InputDecoration(
                    hintText: 'Enter Account details',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintStyle:
                        TextStyle(color: ColorRes.dimGrey3, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 39),
              Container(
                height: 41,
                width: Get.width,
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
                    AppRes.submit,
                    style: TextStyle(
                      color: ColorRes.white,
                      fontSize: 12,
                      fontFamily: 'gilroy_semibold',
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

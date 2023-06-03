import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/custom_box_shadow.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class UserPopUp extends StatelessWidget {
  final VoidCallback onMoreInfoTap;
  final VoidCallback onCancelTap;

  const UserPopUp({
    Key? key,
    required this.onMoreInfoTap,
    required this.onCancelTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: ColorRes.grey18.withOpacity(0.20),
      insetPadding: EdgeInsets.symmetric(horizontal: Get.width / 4.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            CustomBoxShadow(
              offset: const Offset(0, 0),
              color: ColorRes.black.withOpacity(0.15),
              blurRadius: 18,
              style: BlurStyle.outer,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
            child: Container(
              height: 274,
              width: 208,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 26),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      AssetRes.profile6,
                      height: 99,
                      width: 99,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        AppRes.nataliaNora,
                        style: TextStyle(
                          color: ColorRes.darkGrey5,
                          fontSize: 18,
                          fontFamily: 'gilroy_bold',
                        ),
                      ),
                      const Text(
                        AppRes.twentyFour,
                        style: TextStyle(
                          color: ColorRes.darkGrey5,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Image.asset(AssetRes.tickMark, height: 16.5, width: 16.5),
                    ],
                  ),
                  const Text(
                    AppRes.newYorkUsa,
                    style: TextStyle(
                      color: ColorRes.grey19,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 9),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: onMoreInfoTap,
                    child: Container(
                      height: 38.5,
                      width: 127,
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
                      child: const Center(
                        child: Text(
                          AppRes.moreInfo,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 11,
                            fontFamily: 'gilroy_bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: onCancelTap,
                    child: const Text(
                      AppRes.cancel,
                      style: TextStyle(
                        color: ColorRes.grey20,
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
    );
  }
}

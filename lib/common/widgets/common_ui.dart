import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class CommonUI {
  static Widget profileImagePlaceHolder(
      {required String? name, double heightWeight = 0, double? borderRadius}) {
    return Container(
      width: heightWeight,
      height: heightWeight,
      decoration: BoxDecoration(
          color: ColorRes.orange2.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius ?? 50)),
      alignment: Alignment.center,
      child: Text(
        (name ?? 'Unknown')[0].toUpperCase(),
        style: TextStyle(
            fontFamily: FontRes.semiBold,
            fontSize: heightWeight / 2,
            color: ColorRes.orange2),
      ),
    );
  }

  static Widget postPlaceHolder() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(color: ColorRes.lightGrey),
      alignment: Alignment.center,
      child: Image.asset(
        AssetRes.icPostPlaceholder,
        height: 200 / 3,
        color: ColorRes.grey,
      ),
    );
  }

  static String fullName(String? fullName) {
    return fullName ?? 'Unknown';
  }

  static Widget noData() {
    return Center(
      child: Text(
        S.current.noData,
        style: const TextStyle(
            fontFamily: FontRes.semiBold,
            fontSize: 18,
            color: ColorRes.dimGrey1),
      ),
    );
  }

  static Future<void> lottieLoader() {
    return showDialog(
        context: Get.context!,
        builder: (context) {
          return Center(
              child: Lottie.asset(AssetRes.loadingLottie,
                  height: 100, width: 100));
        },
        barrierLabel: '');
  }

  static Widget lottieWidget() {
    return Center(
      child: Lottie.asset(AssetRes.loadingLottie, height: 100, width: 100),
    );
  }
}

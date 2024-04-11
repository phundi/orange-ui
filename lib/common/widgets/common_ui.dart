import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class CommonUI {
  static Widget profileImagePlaceHolder({required String? name, double heightWeight = 0}) {
    return Container(
      width: heightWeight,
      height: heightWeight,
      decoration: BoxDecoration(color: ColorRes.orange2.withOpacity(0.1), shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        (name ?? 'Unknown')[0].toUpperCase(),
        style: TextStyle(fontFamily: FontRes.semiBold, fontSize: heightWeight / 2, color: ColorRes.orange2),
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
}

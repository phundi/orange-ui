import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/hashtag_screen/hashtag_screen.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class DetectableTextCustom extends StatelessWidget {
  final String text;
  const DetectableTextCustom({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetectableText(
      text: text,
      onTap: (p0) {
        Get.to(() => HashtagScreen(hashtagName: p0));
      },
      detectionRegExp: RegExp(r"\B#\w\w+"),
      detectedStyle: const TextStyle(
          fontFamily: FontRes.bold, color: ColorRes.orange2, fontSize: 16),
      basicStyle: const TextStyle(
          color: ColorRes.dimGrey3, fontSize: 16, fontFamily: FontRes.medium),
      trimExpandedText: ' ${S.of(context).readLess}',
      trimCollapsedText: S.of(context).readMore,
      moreStyle: const TextStyle(
          fontFamily: FontRes.bold, color: ColorRes.orange2, fontSize: 16),
      lessStyle: const TextStyle(
          fontFamily: FontRes.bold, color: ColorRes.orange2, fontSize: 16),
    );
  }
}

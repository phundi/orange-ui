import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/hashtag_screen/hashtag_screen.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class TextPost extends StatelessWidget {
  final String? description;

  const TextPost({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: description != null,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
        child: DetectableText(
          text: description ?? '',
          detectionRegExp: RegExp(r"\B#\w\w+"),
          onTap: (p0) {
            Get.to(() => HashtagScreen(hashtagName: p0));
          },
          detectedStyle: const TextStyle(
              fontFamily: FontRes.bold, color: ColorRes.orange2, fontSize: 16),
          basicStyle: const TextStyle(
              color: ColorRes.dimGrey3,
              fontSize: 16,
              fontFamily: FontRes.medium),
        ),
      ),
    );
  }
}

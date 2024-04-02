import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/create_post_screen/create_post_screen_view_model.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:orange_ui/utils/style_res.dart';

class CreatePostPage extends StatelessWidget {
  final CreatePostScreenViewModel model;

  const CreatePostPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreatePostTopBarView(
          type: 0,
          model: model,
        ),
        Container(
          color: ColorRes.alabaster,
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RowImageText(image: AssetRes.icPhoto, title: S.current.photo),
              Container(height: 20, width: 1, color: ColorRes.lightGrey),
              RowImageText(image: AssetRes.icVideo, title: S.current.videoCap.capitalize ?? '')
            ],
          ),
        ),
        Expanded(
          child: DetectableTextField(
            maxLines: null,
            minLines: null,
            expands: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: S.of(context).writeSomethingHere,
              hintStyle: const TextStyle(fontSize: 17, fontFamily: FontRes.regular, color: ColorRes.dimGrey2),
              contentPadding: const EdgeInsets.all(15),
            ),
            style: const TextStyle(fontSize: 18, color: ColorRes.dimGrey3, fontFamily: FontRes.regular),
            detectedStyle: const TextStyle(fontSize: 18, color: ColorRes.orange2, fontFamily: FontRes.medium),
          ),
        )
      ],
    );
  }
}

class CreatePostTopBarView extends StatelessWidget {
  final int type;
  final CreatePostScreenViewModel model;

  const CreatePostTopBarView({Key? key, required this.type, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_rounded,
                  color: ColorRes.veryDarkGrey4,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      S.of(context).createPost,
                      style: const TextStyle(
                          fontFamily: FontRes.semiBold, fontSize: 18, color: ColorRes.veryDarkGrey4),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => model.onNextClick(type),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 17),
                    decoration: ShapeDecoration(
                        shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)),
                        color: model.pageType == 1 ? null : ColorRes.aquaHaze,
                        gradient: model.pageType == 1 ? StyleRes.linearGradient : null),
                    child: Text(
                      (type == 0 ? S.of(context).next : S.of(context).post).toUpperCase(),
                      style: TextStyle(
                          color: model.pageType == 1 ? ColorRes.white : ColorRes.dimGrey5,
                          fontFamily: FontRes.semiBold,
                          fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 1,
            thickness: 0.5,
            color: ColorRes.lightGrey,
          )
        ],
      ),
    );
  }
}

class RowImageText extends StatelessWidget {
  final String image;
  final String title;

  const RowImageText({Key? key, required this.image, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, width: 22, height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(title,
              style: const TextStyle(fontFamily: FontRes.regular, fontSize: 17, color: ColorRes.dimGrey5)),
        )
      ],
    );
  }
}

import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppBar().preferredSize.height * 1.3),
      decoration: const ShapeDecoration(
        color: ColorRes.white,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.vertical(top: SmoothRadius(cornerRadius: 40, cornerSmoothing: 0)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Text(
                S.of(context).comments,
                style: const TextStyle(color: ColorRes.veryDarkGrey4, fontFamily: FontRes.bold, fontSize: 18),
              ),
            ),
          ),
          const Divider(color: ColorRes.greyShade200, thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: SmoothBorderRadius(cornerRadius: 7, cornerSmoothing: 1),
                              child: Image.asset(
                                AssetRes.icImage,
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      '@jessi_robinson',
                                      style: TextStyle(
                                          color: ColorRes.veryDarkGrey4,
                                          fontFamily: FontRes.semiBold,
                                          fontSize: 16),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: ColorRes.dimGrey6,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const Text(
                                    '  33 mins',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: ColorRes.dimGrey3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              AssetRes.icBin,
                              height: 22,
                              width: 22,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DetectableText(
                            text:
                                'If you look at what you have in #life, you\'ll always have more. If you look at what y ou don\'t have in life, you\'ll never have #enough',
                            detectionRegExp: RegExp(r"\B#\w\w+"),
                            detectedStyle:
                                const TextStyle(fontFamily: FontRes.bold, color: ColorRes.orange2, fontSize: 14),
                            basicStyle: const TextStyle(
                                color: ColorRes.dimGrey3, fontSize: 14, fontFamily: FontRes.medium),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(
                      color: ColorRes.greyShade200,
                      thickness: 1,
                      height: 1,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: ColorRes.white,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  const Divider(color: ColorRes.greyShade200, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: SmoothBorderRadius(cornerRadius: 7, cornerSmoothing: 1),
                          child: Image.asset(
                            AssetRes.icImage,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: ShapeDecoration(
                              shape: SmoothRectangleBorder(
                                  side: const BorderSide(color: ColorRes.greyShade200),
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius: 30,
                                  )),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: DetectableTextField(
                                      detectedStyle: const TextStyle(
                                          fontFamily: FontRes.bold, color: ColorRes.orange2, fontSize: 14),
                                      style: const TextStyle(
                                          color: ColorRes.dimGrey3, fontSize: 14, fontFamily: FontRes.medium),
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                                          border: InputBorder.none,
                                          hintText: S.of(context).addComment,
                                          hintStyle: const TextStyle(
                                              fontFamily: FontRes.medium, fontSize: 12, color: ColorRes.dimGrey3)),
                                      textAlignVertical: TextAlignVertical.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        colors: [ColorRes.lightOrange1, ColorRes.darkOrange],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                  ),
                                  child: Image.asset(
                                    AssetRes.share,
                                    height: 15,
                                    alignment: Alignment.centerRight,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

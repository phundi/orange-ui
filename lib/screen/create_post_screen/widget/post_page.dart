import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/gradient_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/create_post_screen/create_post_screen_view_model.dart';
import 'package:orange_ui/screen/create_post_screen/widget/creat_post_page.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:orange_ui/utils/style_res.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostPage extends StatelessWidget {
  final CreatePostScreenViewModel model;

  const PostPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreatePostTopBarView(type: 1, model: model),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                child: DetectableText(
                  text:
                      'If you look at what you have in #life, you\'ll always have more. If you look at what y ou don\'t have in life, you\'ll never have #enough',
                  detectionRegExp: RegExp(r"\B#\w\w+"),
                  detectedStyle: const TextStyle(fontFamily: FontRes.bold, color: ColorRes.orange2, fontSize: 16),
                  basicStyle: const TextStyle(color: ColorRes.dimGrey3, fontSize: 16, fontFamily: FontRes.medium),
                ),
              ),
              ImagePost(model: model),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 5.0),
                child: Text(
                  S.of(context).selectInterestsToContinue,
                  style: const TextStyle(fontFamily: FontRes.semiBold, fontSize: 18, color: ColorRes.darkGrey),
                ),
              ),
              Center(
                child: SafeArea(
                  top: false,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      model.interests.length,
                      (index) {
                        bool isSelected = model.selectedInterests.contains(model.interests[index]);
                        return InkWell(
                          onTap: () => model.onInterestTap(model.interests[index]),
                          child: isSelected
                              ? Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: UnicornOutlineButton(
                                    strokeWidth: 3,
                                    radius: 30,
                                    gradient: StyleRes.linearGradient,
                                    onPressed: () => model.onInterestTap(model.interests[index]),
                                    margin: EdgeInsets.zero,
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                                    child: GradientText(
                                      model.interests[index].toUpperCase(),
                                      gradient: StyleRes.linearGradient,
                                      style: const TextStyle(
                                          fontFamily: FontRes.bold, fontSize: 12, letterSpacing: 0.5),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                                  decoration: ShapeDecoration(
                                    shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                      cornerRadius: 30,
                                    )),
                                    color: ColorRes.aquaHaze,
                                  ),
                                  child: Text(
                                    model.interests[index].toUpperCase(),
                                    style: const TextStyle(
                                        color: ColorRes.grey19,
                                        fontFamily: FontRes.bold,
                                        fontSize: 12,
                                        letterSpacing: 0.5),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}

class VideoPost extends StatelessWidget {
  const VideoPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AssetRes.icImage,
            height: 390,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: FittedBox(
                  child: Container(
                    height: 39,
                    width: 39,
                    margin: const EdgeInsets.all(15),
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)),
                      color: ColorRes.white.withOpacity(0.3),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(AssetRes.icBin, color: ColorRes.white, width: 21, height: 21),
                  ),
                ),
              ),
              Container(
                width: 55,
                height: 55,
                margin: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)),
                  color: ColorRes.black.withOpacity(0.4),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  AssetRes.icPlay,
                  color: ColorRes.white,
                  width: 20,
                  height: 20,
                  alignment: Alignment.centerRight,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                    shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(cornerRadius: 5, cornerSmoothing: 1)),
                    color: ColorRes.black.withOpacity(0.3)),
                child: Row(
                  children: [
                    const Text(
                      '00:31',
                      style: TextStyle(
                          color: ColorRes.white, fontFamily: FontRes.light, fontSize: 12, letterSpacing: 0.5),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(trackHeight: 2, overlayShape: SliderComponentShape.noOverlay),
                        child: Slider(
                            value: 10,
                            max: 20,
                            activeColor: ColorRes.darkOrange,
                            onChanged: (value) {},
                            inactiveColor: ColorRes.dimGrey3),
                      ),
                    ),
                    const Text(
                      '00:56',
                      style: TextStyle(
                          color: ColorRes.white, fontFamily: FontRes.light, fontSize: 12, letterSpacing: 0.5),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ImagePost extends StatelessWidget {
  final CreatePostScreenViewModel model;

  const ImagePost({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          /// For Single Image
          // Image.asset(AssetRes.icImage4, fit: BoxFit.cover, height: null, width: double.infinity),

          /// For Multiple Image
          SizedBox(
            height: 390,
            child: PageView.builder(
              controller: model.pageController,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Image.asset(AssetRes.icImage4, fit: BoxFit.cover, height: 390, width: double.infinity);
              },
            ),
          ),

          Positioned(
            right: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)),
                      color: ColorRes.white.withOpacity(0.3),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.add_rounded, color: ColorRes.white),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)),
                      color: ColorRes.white.withOpacity(0.3),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(AssetRes.icBin, color: ColorRes.white, width: 21, height: 21),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SmoothPageIndicator(
                controller: model.pageController, // PageController

                effect: CustomizableEffect(
                    dotDecoration: DotDecoration(width: 31, height: 2, color: ColorRes.white.withOpacity(0.3)),
                    activeDotDecoration:
                        const DotDecoration(width: 31, height: 2, color: ColorRes.white)), // your preferred effect
                onDotClicked: (index) {}, count: 5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

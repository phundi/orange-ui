import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/screen/create_post_screen/create_post_screen_view_model.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:video_player/video_player.dart';

class VideoPostView extends StatelessWidget {
  final CreatePostScreenViewModel model;

  const VideoPostView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      width: double.infinity,
      color: ColorRes.black,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: model.videoPlayerController == null
          ? const SizedBox()
          : Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: model.videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(model.videoPlayerController!),
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
                    InkWell(
                      onTap: () {
                        model.videoPlayerController?.play();
                      },
                      child: Container(
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
                          Obx(
                            () => SizedBox(
                              width: 35,
                              child: Text(
                                CommonFun.printDuration(model.currentDuration.value),
                                style: const TextStyle(
                                    color: ColorRes.white, fontFamily: FontRes.light, fontSize: 12, letterSpacing: 0.5),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 2,
                                  overlayShape: SliderComponentShape.noOverlay,
                                ),
                                child: Slider(
                                    value: model.currentDuration.value.inMilliseconds.toDouble(),
                                    max: model.videoPlayerController!.value.duration.inMilliseconds.toDouble(),
                                    activeColor: ColorRes.darkOrange,
                                    onChanged: model.onChangeSlider,
                                    inactiveColor: ColorRes.dimGrey3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            CommonFun.printDuration(model.videoPlayerController!.value.duration),
                            style: const TextStyle(
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

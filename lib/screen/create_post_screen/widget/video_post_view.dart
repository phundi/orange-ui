import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class VideoPostView extends StatelessWidget {
  const VideoPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(AssetRes.icImage, height: 390, width: double.infinity, fit: BoxFit.cover),
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
                child: Image.asset(AssetRes.icPlay,
                    color: ColorRes.white, width: 20, height: 20, alignment: Alignment.centerRight),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                    shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 5, cornerSmoothing: 1)),
                    color: ColorRes.black.withOpacity(0.3)),
                child: Row(
                  children: [
                    const Text(
                      '00:31',
                      style:
                          TextStyle(color: ColorRes.white, fontFamily: FontRes.light, fontSize: 12, letterSpacing: 0.5),
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
                      style:
                          TextStyle(color: ColorRes.white, fontFamily: FontRes.light, fontSize: 12, letterSpacing: 0.5),
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

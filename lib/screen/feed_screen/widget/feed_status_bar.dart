import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class FeedStatusBar extends StatelessWidget {
  const FeedStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          height: 80,
          margin: const EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 5),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipRRect(
                borderRadius: SmoothBorderRadius(cornerRadius: 15, cornerSmoothing: 1),
                child: Image.asset(AssetRes.icImage, width: 70, height: 70, fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Image.asset(AssetRes.add, height: 30, width: 30),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 90,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: ListView.builder(
                itemCount: 5,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 80,
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: ShapeDecoration(
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(cornerRadius: 15, cornerSmoothing: 1),
                            ),
                            gradient: const LinearGradient(
                                colors: [ColorRes.lightOrange1, ColorRes.darkOrange],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: Container(
                            width: 66,
                            height: 66,
                            margin: const EdgeInsets.all(2.5),
                            decoration: ShapeDecoration(
                                color: ColorRes.white,
                                shape: SmoothRectangleBorder(
                                    side: const BorderSide(color: ColorRes.white),
                                    borderRadius: SmoothBorderRadius(cornerRadius: 13, cornerSmoothing: 1))),
                            child: ClipRRect(
                              borderRadius: SmoothBorderRadius(cornerRadius: 13, cornerSmoothing: 1),
                              child: Image.asset(AssetRes.icImage, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        const Text(
                          'shirley_setia',
                          style: TextStyle(color: ColorRes.dimGrey3, fontSize: 13, fontFamily: FontRes.semiBold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class LiveGridTopArea extends StatelessWidget {
  final VoidCallback onBackBtnTap;
  final VoidCallback onGoLiveTap;

  const LiveGridTopArea({
    Key? key,
    required this.onBackBtnTap,
    required this.onGoLiveTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 40, 18, 19),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onBackBtnTap,
            child: Container(
              height: 37,
              width: 37,
              padding: const EdgeInsets.fromLTRB(11, 11, 14, 11),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetRes.backButton),
                ),
              ),
              child: Image.asset(
                AssetRes.backArrow,
              ),
            ),
          ),
          const SizedBox(width: 13),
          Image.asset(AssetRes.themeLabel, height: 23, width: 76),
          const Text(
            " ${AppRes.live}",
            style: TextStyle(
              fontSize: 16,
              color: ColorRes.black2,
            ),
          ),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onGoLiveTap,
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorRes.lightOrange1,
                    ColorRes.darkOrange,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    AssetRes.sun,
                    height: 21,
                    width: 21,
                    color: ColorRes.white,
                  ),
                  const SizedBox(width: 7.62),
                  const Text(
                    AppRes.goLive,
                    style: TextStyle(
                      color: ColorRes.white,
                      fontSize: 14,
                      fontFamily: 'gilroy_extra_bold',
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

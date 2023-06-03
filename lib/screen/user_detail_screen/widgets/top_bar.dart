import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onBackTap;
  final VoidCallback onMoreBtnTap;

  const TopBar({
    Key? key,
    required this.onBackTap,
    required this.onMoreBtnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: ColorRes.black.withOpacity(0.33),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: onBackTap,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Image.asset(
                          AssetRes.backArrow,
                          height: 18,
                          width: 10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: onMoreBtnTap,
                      child: Image.asset(
                        AssetRes.moreHorizontal,
                        height: 10,
                        width: 26.74,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      AppRes.nataliaNora,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 16,
                        fontFamily: "gilroy_bold",
                      ),
                    ),
                    const Text(
                      AppRes.twentyFour,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 5.7),
                    Image.asset(AssetRes.tickMark, height: 16, width: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/gradient_widget.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class BottomButtons extends StatelessWidget {
  final VoidCallback onPlayBtnTap;
  final VoidCallback onNextBtnTap;
  final VoidCallback onEyeTap;

  const BottomButtons({
    Key? key,
    required this.onPlayBtnTap,
    required this.onNextBtnTap,
    required this.onEyeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: onPlayBtnTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 51,
            width: 51,
            decoration: BoxDecoration(
              color: ColorRes.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1.7, 1.5),
                  color: ColorRes.lightGrey.withOpacity(0.7),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Center(
              child: Transform.rotate(
                angle: 3.1,
                child: GradientWidget(
                  child: Image.asset(
                    AssetRes.playButton,
                    height: 25,
                    width: 25,
                    color: ColorRes.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: onNextBtnTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 51,
            width: 142,
            decoration: BoxDecoration(
              color: ColorRes.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1.7, 1.5),
                  color: ColorRes.lightGrey.withOpacity(0.7),
                  blurRadius: 3,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                AppRes.next,
                style: TextStyle(
                  color: ColorRes.orange2,
                  fontSize: 17,
                  fontFamily: "gilroY_bold",
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: onEyeTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 51,
            width: 51,
            decoration: BoxDecoration(
              color: ColorRes.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1.7, 1.5),
                  color: ColorRes.lightGrey.withOpacity(0.7),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Center(
              child: GradientWidget(
                child: Image.asset(
                  AssetRes.eye,
                  height: 20,
                  width: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

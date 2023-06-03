import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class VideoUploadDialog extends StatelessWidget {
  final VoidCallback selectAnother;
  final VoidCallback cancelBtnTap;

  const VideoUploadDialog(
      {Key? key, required this.cancelBtnTap, required this.selectAnother})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: AspectRatio(
          aspectRatio: 0.9,
          child: Column(
            children: [
              const Spacer(flex: 2),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontFamily: FontRes.semiBold, fontSize: 18),
                  children: [
                    TextSpan(
                      text: S.of(context).tooLarge,
                      style: const TextStyle(color: ColorRes.grey15),
                    ),
                    TextSpan(
                      text: ' ${S.of(context).video}',
                      style: const TextStyle(color: ColorRes.darkGrey),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Image(
                image: AssetImage(AssetRes.themeLabel),
                width: 100,
              ),
              const Spacer(
                flex: 2,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  S.of(context).thisVideoIsGreaterThan50MbnpleaseSelectAnother,
                  style: const TextStyle(
                      fontFamily: FontRes.semiBold, color: ColorRes.grey15),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              InkWell(
                highlightColor: ColorRes.transparent,
                splashColor: ColorRes.transparent,
                onTap: selectAnother,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ColorRes.lightOrange1,
                        ColorRes.darkOrange,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    S.of(context).selectAnother,
                    style: const TextStyle(
                        color: ColorRes.white, fontFamily: FontRes.semiBold),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                highlightColor: ColorRes.transparent,
                splashColor: ColorRes.transparent,
                onTap: cancelBtnTap,
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    S.current.cancel,
                    style: const TextStyle(
                        color: ColorRes.grey15, fontFamily: FontRes.semiBold),
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

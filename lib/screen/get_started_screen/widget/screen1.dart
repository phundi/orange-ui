import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class Screen1 extends StatelessWidget {
  final VoidCallback onTap;

  const Screen1({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: ColorRes.white,
      child: Stack(
        alignment: const AlignmentDirectional(0, 0.8),
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetRes.themeLabel,
                  width: Get.width / 1.7,
                  fit: BoxFit.cover,
                ),
                Visibility(
                  visible: PrefService.settingData?.appdata?.isDating == 1,
                  child: Text(
                    S.current.getStarted1Subtitle,
                    style: const TextStyle(
                      color: ColorRes.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          submitBtn(),
        ],
      ),
    );
  }

  Widget submitBtn() {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 238,
        decoration: BoxDecoration(
          color: ColorRes.orange1.withOpacity(0.14),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            S.current.continueText,
            style: const TextStyle(
              color: ColorRes.orange,
              fontSize: 15,
              fontFamily: FontRes.semiBold,
            ),
          ),
        ),
      ),
    );
  }
}

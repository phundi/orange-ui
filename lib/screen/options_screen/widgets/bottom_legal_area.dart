import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class BottomLegalArea extends StatelessWidget {
  final VoidCallback onPrivacyPolicyTap;
  final VoidCallback onTermsOfUseTap;
  final VoidCallback onLogoutTap;
  final VoidCallback onDeleteAccountTap;

  const BottomLegalArea({
    Key? key,
    required this.onPrivacyPolicyTap,
    required this.onTermsOfUseTap,
    required this.onLogoutTap,
    required this.onDeleteAccountTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.legal,
          style: const TextStyle(
            fontFamily: FontRes.bold,
            color: ColorRes.grey23,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 9),
        navigationTile(S.current.privacyPolicy, onPrivacyPolicyTap),
        const SizedBox(height: 8),
        navigationTile(S.current.termsOfUse, onTermsOfUseTap),
        const SizedBox(height: 47),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onLogoutTap,
          child: Container(
            height: 46,
            width: Get.width,
            decoration: BoxDecoration(
              color: ColorRes.grey12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                S.current.logOut,
                style: const TextStyle(
                  fontSize: 15,
                  color: ColorRes.grey24,
                  fontFamily: FontRes.semiBold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Image.asset(AssetRes.themeLabel, height: 28, width: 93),
        ),
        Center(
          child: Text(
            S.current.versionText,
            style: const TextStyle(
              fontSize: 12,
              color: ColorRes.grey25,
            ),
          ),
        ),
        const SizedBox(height: 23),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onDeleteAccountTap,
          child: Container(
            height: 46,
            width: Get.width,
            decoration: BoxDecoration(
              color: ColorRes.grey12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                S.current.deleteAccount,
                style: const TextStyle(
                  fontSize: 15,
                  color: ColorRes.grey24,
                  fontFamily: FontRes.semiBold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget navigationTile(String title, VoidCallback onTap) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: ColorRes.grey12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: ColorRes.grey24,
                fontSize: 15,
                fontFamily: FontRes.semiBold,
              ),
            ),
            const Spacer(),
            Transform.rotate(
              angle: 3.2,
              child: Image.asset(
                AssetRes.backArrow,
                height: 12,
                width: 6,
              ),
            )
          ],
        ),
      ),
    );
  }
}

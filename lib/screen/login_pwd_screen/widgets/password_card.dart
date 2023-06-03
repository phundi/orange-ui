import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/buttons.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class PasswordCard extends StatelessWidget {
  final TextEditingController pwdController;
  final FocusNode pwdFocus;
  final String pwdError;
  final bool showPwd;
  final VoidCallback onContinueTap;
  final VoidCallback onForgotPwdTap;
  final VoidCallback onViewBtnTap;

  const PasswordCard({
    Key? key,
    required this.pwdController,
    required this.pwdFocus,
    required this.pwdError,
    required this.showPwd,
    required this.onContinueTap,
    required this.onForgotPwdTap,
    required this.onViewBtnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 30),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorRes.black.withOpacity(0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileBox(),
              const SizedBox(height: 30),
              Container(
                height: 44,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextField(
                  focusNode: pwdFocus,
                  controller: pwdController,
                  obscureText: !showPwd,
                  style: const TextStyle(
                    fontFamily: 'gilroy_semibold',
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 14, top: 10),
                    border: InputBorder.none,
                    hintText: pwdError == "" ? AppRes.password : pwdError,
                    suffixIcon: InkWell(
                      onTap: onViewBtnTap,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          showPwd ? AppRes.hide : AppRes.view,
                          style: const TextStyle(
                            color: ColorRes.veryDarkGrey2,
                            fontSize: 13,
                            fontFamily: 'gilroy_bold',
                          ),
                        ),
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: pwdError == "" ? ColorRes.dimGrey2 : ColorRes.red,
                      fontSize: 14,
                      fontFamily: 'gilroy_semibold',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SubmitButton1(title: AppRes.continueText, onTap: onContinueTap),
              const SizedBox(height: 28),
              InkWell(
                onTap: onForgotPwdTap,
                child: const Text(
                  AppRes.forgotYourPassword,
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileBox() {
    return SizedBox(
      child: Row(
        children: [
          Image.asset(AssetRes.profile1, height: 45, width: 45),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                AppRes.userFullName,
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 16,
                  fontFamily: "gilroy_semibold",
                ),
              ),
              Text(
                AppRes.userEmail,
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 12,
                  fontFamily: "gilroy",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

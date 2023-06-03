import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/buttons.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class RegisterCard extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController pwdController;
  final TextEditingController confirmPwdController;
  final FocusNode fullNameFocus;
  final FocusNode pwdFocus;
  final FocusNode confirmPwdFocus;
  final bool showPwd;
  final String fullNameError;
  final String pwdError;
  final String confirmPwdError;
  final VoidCallback onViewTap;
  final VoidCallback onContinueTap;

  const RegisterCard({
    Key? key,
    required this.fullNameController,
    required this.pwdController,
    required this.confirmPwdController,
    required this.fullNameFocus,
    required this.pwdFocus,
    required this.confirmPwdFocus,
    required this.showPwd,
    required this.fullNameError,
    required this.pwdError,
    required this.confirmPwdError,
    required this.onViewTap,
    required this.onContinueTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 30),
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorRes.black.withOpacity(0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppRes.registerInfoText,
                style: TextStyle(
                  color: ColorRes.lightGrey,
                  fontSize: 15,
                ),
              ),
              const Text(
                AppRes.exampleEmail,
                style: TextStyle(
                  color: ColorRes.lightGrey,
                  fontSize: 15,
                  fontFamily: 'gilroy_semibold',
                ),
              ),
              const SizedBox(height: 25),
              textField(
                controller: fullNameController,
                focusNode: fullNameFocus,
                error: fullNameError,
                hint: AppRes.fullName,
              ),
              const SizedBox(height: 20),
              textField(
                  controller: pwdController,
                  focusNode: pwdFocus,
                  error: pwdError,
                  hint: AppRes.password,
                  showPwd: showPwd,
                  onViewTap: onViewTap),
              const SizedBox(height: 20),
              textField(
                controller: confirmPwdController,
                focusNode: confirmPwdFocus,
                error: confirmPwdError,
                hint: AppRes.confirmPassword,
                showPwd: false,
              ),
              const SizedBox(height: 25),
              policyText(),
              const SizedBox(height: 30),
              SubmitButton1(title: AppRes.agreeNContinue, onTap: onContinueTap),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String error,
    required String hint,
    bool? showPwd,
    VoidCallback? onViewTap,
  }) {
    return Container(
      height: 44,
      width: Get.width,
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: showPwd == null ? false : !showPwd,
        style: const TextStyle(
          fontFamily: 'gilroy_semibold',
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 14, top: 10),
          border: InputBorder.none,
          hintText: error == "" ? hint : error,
          suffixIcon: onViewTap == null
              ? const SizedBox()
              : InkWell(
                  onTap: onViewTap,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      showPwd! ? AppRes.hide : AppRes.view,
                      style: const TextStyle(
                        color: ColorRes.veryDarkGrey2,
                        fontSize: 13,
                        fontFamily: 'gilroy_bold',
                      ),
                    ),
                  ),
                ),
          hintStyle: TextStyle(
            color: error == "" ? ColorRes.dimGrey2 : ColorRes.red,
            fontSize: 14,
            fontFamily: "gilroy_semibold",
          ),
        ),
      ),
    );
  }

  Widget policyText() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: AppRes.policy1,
            style: TextStyle(
              color: ColorRes.lightGrey,
              fontSize: 13,
              fontFamily: "gilroy",
            ),
          ),
          TextSpan(
            text: AppRes.policy2,
            style: TextStyle(
              color: ColorRes.lightOrange3,
              fontSize: 13,
              fontFamily: "gilroy_semibold",
            ),
          ),
          TextSpan(
            text: AppRes.policy3,
            style: TextStyle(
              color: ColorRes.lightGrey,
              fontSize: 13,
              fontFamily: "gilroy",
            ),
          ),
          TextSpan(
            text: AppRes.policy4,
            style: TextStyle(
              color: ColorRes.lightOrange3,
              fontSize: 13,
              fontFamily: "gilroy_semibold",
            ),
          ),
        ],
      ),
    );
  }
}

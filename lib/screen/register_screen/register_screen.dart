import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/register_screen/register_screen_view_model.dart';
import 'package:orange_ui/screen/register_screen/widgets/register_card.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => RegisterScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Image.asset(
                  AssetRes.loginBG,
                  height: Get.height,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Get.height / 6),
                      Image.asset(
                        AssetRes.themeLabelWhite,
                        height: 51,
                        width: 176,
                      ),
                      SizedBox(height: Get.height / 18),
                      Row(
                        children: const [
                          SizedBox(width: 20),
                          Text(
                            AppRes.register,
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 25,
                              fontFamily: 'gilroy_extra_bold',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      RegisterCard(
                        fullNameController: model.fullNameController,
                        pwdController: model.pwdController,
                        confirmPwdController: model.confirmPwdController,
                        fullNameFocus: model.fullNameFocus,
                        pwdFocus: model.pwdFocus,
                        confirmPwdFocus: model.confirmPwdFocus,
                        showPwd: model.showPwd,
                        fullNameError: model.fullNameError,
                        pwdError: model.pwdError,
                        confirmPwdError: model.confirmPwdError,
                        onViewTap: model.onViewTap,
                        onContinueTap: model.onContinueTap,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/drop_down_box.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/edit_profile_screen/edit_profile_screen_view_model.dart';
import 'package:orange_ui/screen/edit_profile_screen/widgets/interest_list.dart';
import 'package:orange_ui/screen/edit_profile_screen/widgets/text_field_area/text_field_controller.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

const kTextFieldFontStyle = TextStyle(
  color: ColorRes.dimGrey3,
  fontSize: 14,
);

class TextFieldsArea extends StatelessWidget {
  final EditProfileScreenViewModel model;

  TextFieldsArea({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ProfileTextFieldController controller =
      Get.put(ProfileTextFieldController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              S.current.fullNameCap,
              style: const TextStyle(
                color: ColorRes.darkGrey3,
                fontSize: 15,
                fontFamily: FontRes.extraBold,
              ),
            ),
          ),
          _textField(
              controller: model.fullNameController,
              focusNode: model.fullNameFocus,
              error: model.fullNameError,
              hint: S.current.enterFullName),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Obx(
              () => RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: S.current.bio,
                      style: const TextStyle(
                        color: ColorRes.darkGrey3,
                        fontSize: 15,
                        fontFamily: FontRes.extraBold,
                      ),
                    ),
                    TextSpan(
                      text: " (${S.current.optional})",
                      style: const TextStyle(
                        color: ColorRes.dimGrey2,
                        fontSize: 14,
                        fontFamily: FontRes.bold,
                      ),
                    ),
                    TextSpan(
                      text: " (${controller.bio.value.length}/100)",
                      style: const TextStyle(
                        color: ColorRes.dimGrey2,
                        fontSize: 14,
                        fontFamily: FontRes.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: ColorRes.lightGrey2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: model.bioController,
              focusNode: model.bioFocus,
              onTap: model.onAllScreenTap,
              maxLines: null,
              minLines: null,
              expands: true,
              textInputAction: TextInputAction.next,
              maxLength: 100,
              onChanged: controller.onBioChange,
              style: kTextFieldFontStyle,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText:
                    model.bioError == '' ? S.current.enterBio : model.bioError,
                hintStyle: TextStyle(
                  color:
                      model.bioError == "" ? ColorRes.dimGrey2 : ColorRes.red,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.only(bottom: 10, left: 10, top: 9),
                counterText: "",
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Obx(
              () => RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: S.current.about,
                      style: const TextStyle(
                        color: ColorRes.darkGrey3,
                        fontSize: 15,
                        fontFamily: FontRes.extraBold,
                      ),
                    ),
                    TextSpan(
                      text: " (${controller.about.value.length}/300)",
                      style: const TextStyle(
                        color: ColorRes.dimGrey2,
                        fontSize: 14,
                        fontFamily: FontRes.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: ColorRes.lightGrey2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: model.aboutController,
              focusNode: model.aboutFocus,
              onTap: model.onAllScreenTap,
              textInputAction: TextInputAction.next,
              maxLines: null,
              minLines: null,
              expands: true,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 300,
              onChanged: controller.onAboutChange,
              style: kTextFieldFontStyle,
              decoration: InputDecoration(
                hintText: model.aboutError == ''
                    ? S.current.enterAbout
                    : model.aboutError,
                hintStyle: TextStyle(
                  color:
                      model.aboutError == "" ? ColorRes.dimGrey2 : ColorRes.red,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.only(bottom: 10, left: 10, top: 9),
                counterText: "",
              ),
            ),
          ),
          const SizedBox(height: 10),
          _textView(
              title: S.current.whereDoYouLive,
              optional: ' (${S.current.optional})'),
          _textField(
              controller: model.addressController,
              focusNode: model.addressFocus,
              error: model.addressError,
              hint: S.current.enterAddress),
          const SizedBox(height: 10),
          _textView(title: S.current.age, optional: ''),
          _textField(
              controller: model.ageController,
              focusNode: model.ageFocus,
              error: model.ageError,
              hint: S.current.enterAge,
              keyBoardType: TextInputType.phone),
          const SizedBox(height: 10),
          _textView(title: S.current.gender, optional: ''),
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: model.onGenderTap,
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: ColorRes.lightGrey2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.gender,
                              style: const TextStyle(
                                color: ColorRes.dimGrey3,
                                fontSize: 14,
                              ),
                            ),
                            Transform.rotate(
                              angle: model.showDropdown ? 3.1 : 0,
                              child: Image.asset(
                                AssetRes.downArrow,
                                height: 25,
                                width: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _textView(title: S.current.instagram, optional: ''),
                  socialLinkTextField(
                      controller: model.instagramController,
                      focusNode: model.instagramFocus),
                  const SizedBox(height: 10),
                  _textView(title: S.current.facebook, optional: ''),
                  socialLinkTextField(
                      controller: model.facebookController,
                      focusNode: model.facebookFocus),
                  const SizedBox(height: 10),
                  _textView(title: S.current.youtube, optional: ''),
                  socialLinkTextField(
                      controller: model.youtubeController,
                      focusNode: model.youtubeFocus),
                ],
              ),
              model.showDropdown
                  ? Positioned(
                      top: 45,
                      child: DropDownBox(
                        gender: model.gender,
                        onChange: model.onGenderChange,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 15),
          InterestList(model: model),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: model.onSaveTap,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: ColorRes.lightOrange4,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  S.current.save,
                  style: const TextStyle(
                    fontFamily: FontRes.bold,
                    color: ColorRes.red5,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 47),
        ],
      ),
    );
  }

  Widget _textView({required String title, required String optional}) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                  color: ColorRes.darkGrey3,
                  fontSize: 15,
                  fontFamily: FontRes.extraBold,
                ),
              ),
              TextSpan(
                text: optional,
                style: const TextStyle(
                  color: ColorRes.dimGrey2,
                  fontSize: 14,
                  fontFamily: FontRes.bold,
                ),
              )
            ],
          ),
        ));
  }

  Widget socialLinkTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: ColorRes.lightGrey2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onTap: model.onAllScreenTap,
        style: const TextStyle(
          color: ColorRes.dimGrey3,
          fontSize: 14,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 10, left: 10),
        ),
      ),
    );
  }

  Widget _textField(
      {required TextEditingController controller,
      required FocusNode focusNode,
      required String error,
      required String hint,
      TextInputType? keyBoardType}) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: ColorRes.lightGrey2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyBoardType,
        textCapitalization: TextCapitalization.sentences,
        onTap: model.onAllScreenTap,
        style: kTextFieldFontStyle,
        decoration: InputDecoration(
          hintText: error == '' ? hint : error,
          hintStyle: TextStyle(
            color: error == "" ? ColorRes.dimGrey2 : ColorRes.red,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/drop_down_box.dart';
import 'package:orange_ui/screen/edit_profile_screen/widgets/text_field_area/text_field_controller.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class TextFieldsArea extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController addressController;
  final TextEditingController bioController;
  final TextEditingController ageController;
  final TextEditingController instagramController;
  final TextEditingController youtubeController;
  final FocusNode fullNameFocus;
  final FocusNode addressFocus;
  final FocusNode bioFocus;
  final FocusNode ageFocus;
  final FocusNode instagramFocus;
  final FocusNode youtubeFocus;
  final String gender;
  final bool showDropdown;
  final VoidCallback onGenderTap;
  final VoidCallback onTextFieldTap;
  final VoidCallback onPreviewTap;
  final VoidCallback onSaveTap;
  final Function(String value) onGenderChange;

  TextFieldsArea({
    Key? key,
    required this.fullNameController,
    required this.addressController,
    required this.bioController,
    required this.ageController,
    required this.instagramController,
    required this.youtubeController,
    required this.fullNameFocus,
    required this.addressFocus,
    required this.bioFocus,
    required this.ageFocus,
    required this.instagramFocus,
    required this.youtubeFocus,
    required this.gender,
    required this.onGenderTap,
    required this.showDropdown,
    required this.onTextFieldTap,
    required this.onSaveTap,
    required this.onPreviewTap,
    required this.onGenderChange,
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
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              AppRes.fullNameCap,
              style: TextStyle(
                color: ColorRes.darkGrey3,
                fontSize: 15,
                fontFamily: "gilroy_extra_bold",
              ),
            ),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: ColorRes.lightGrey2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: fullNameController,
              focusNode: fullNameFocus,
              onTap: onTextFieldTap,
              style: const TextStyle(
                color: ColorRes.dimGrey3,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 10, left: 10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Obx(() => RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: AppRes.bio,
                        style: TextStyle(
                          color: ColorRes.darkGrey3,
                          fontSize: 15,
                          fontFamily: "gilroy_extra_bold",
                        ),
                      ),
                      TextSpan(
                        text: " (" +
                            controller.bio.value.length.toString() +
                            "/80" +
                            ")",
                        style: const TextStyle(
                          color: ColorRes.dimGrey2,
                          fontSize: 14,
                          fontFamily: 'gilroy_bold',
                        ),
                      )
                    ],
                  ),
                )),
          ),
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: ColorRes.lightGrey2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: bioController,
              focusNode: bioFocus,
              onTap: onTextFieldTap,
              maxLines: null,
              minLines: null,
              expands: true,
              maxLength: 80,
              onChanged: controller.onBioChange,
              style: const TextStyle(
                color: ColorRes.dimGrey3,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 10, left: 10, top: 9),
                counterText: "",
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              AppRes.whereDoYouLive,
              style: TextStyle(
                color: ColorRes.darkGrey3,
                fontSize: 15,
                fontFamily: "gilroy_extra_bold",
              ),
            ),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: ColorRes.lightGrey2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: addressController,
              focusNode: addressFocus,
              onTap: onTextFieldTap,
              onChanged: controller.onAddressChange,
              style: const TextStyle(
                color: ColorRes.dimGrey3,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 10, left: 10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              AppRes.age,
              style: TextStyle(
                color: ColorRes.darkGrey3,
                fontSize: 15,
                fontFamily: "gilroy_extra_bold",
              ),
            ),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: ColorRes.lightGrey2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: ageController,
              focusNode: ageFocus,
              onChanged: controller.onAgeChange,
              onTap: onTextFieldTap,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: ColorRes.dimGrey3,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 10, left: 10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              AppRes.gender,
              style: TextStyle(
                color: ColorRes.darkGrey3,
                fontSize: 15,
                fontFamily: "gilroy_extra_bold",
              ),
            ),
          ),
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: onGenderTap,
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
                              gender,
                              style: const TextStyle(
                                color: ColorRes.dimGrey3,
                                fontSize: 14,
                              ),
                            ),
                            Transform.rotate(
                              angle: showDropdown ? 3.1 : 0,
                              child: Image.asset(
                                AssetRes.downArrow,
                                height: 7,
                                width: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      AppRes.instagram,
                      style: TextStyle(
                        color: ColorRes.darkGrey3,
                        fontSize: 15,
                        fontFamily: "gilroy_extra_bold",
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: ColorRes.lightGrey2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: instagramController,
                      focusNode: instagramFocus,
                      onTap: onTextFieldTap,
                      style: const TextStyle(
                        color: ColorRes.dimGrey3,
                        fontSize: 14,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      AppRes.youtube,
                      style: TextStyle(
                        color: ColorRes.darkGrey3,
                        fontSize: 15,
                        fontFamily: "gilroy_extra_bold",
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: ColorRes.lightGrey2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: youtubeController,
                      focusNode: youtubeFocus,
                      onTap: onTextFieldTap,
                      style: const TextStyle(
                        color: ColorRes.dimGrey3,
                        fontSize: 14,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ],
              ),
              showDropdown
                  ? Positioned(
                      top: 45,
                      child: DropDownBox(
                        gender: gender,
                        onChange: onGenderChange,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 25),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onPreviewTap,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: ColorRes.lightGrey2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  AppRes.preview,
                  style: TextStyle(
                    fontFamily: 'gilroy_bold',
                    color: ColorRes.red5,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onSaveTap,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: ColorRes.lightOrange4,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  AppRes.save,
                  style: TextStyle(
                    fontFamily: 'gilroy_bold',
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

  Widget textField(TextEditingController textController, FocusNode focusNode) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: ColorRes.lightGrey2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: addressController,
        focusNode: addressFocus,
        onTap: onTextFieldTap,
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
}

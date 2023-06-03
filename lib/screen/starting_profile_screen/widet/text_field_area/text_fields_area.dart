import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/drop_down_box.dart';
import 'package:orange_ui/screen/starting_profile_screen/widet/text_field_area/text_field_controller.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class TextFieldsArea extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController bioController;
  final TextEditingController ageController;
  final FocusNode addressFocus;
  final FocusNode bioFocus;
  final FocusNode ageFocus;
  final String gender;
  final bool showDropdown;
  final VoidCallback onGenderTap;
  final VoidCallback onTextFieldTap;
  final Function(String value) onGenderChange;

  TextFieldsArea({
    Key? key,
    required this.addressController,
    required this.bioController,
    required this.ageController,
    required this.addressFocus,
    required this.bioFocus,
    required this.ageFocus,
    required this.gender,
    required this.onGenderTap,
    required this.showDropdown,
    required this.onTextFieldTap,
    required this.onGenderChange,
  }) : super(key: key);

  final TextFieldController controller = Get.put(TextFieldController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppRes.whereDoYouLive,
                style: TextStyle(
                  color: ColorRes.darkGrey3,
                  fontSize: 15,
                  fontFamily: "gilroy_extra_bold",
                ),
              ),
              const SizedBox(height: 6),
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
              const SizedBox(height: 15),
              Obx(() => RichText(
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
              const SizedBox(height: 6),
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
                    contentPadding:
                        EdgeInsets.only(bottom: 10, left: 10, top: 9),
                    counterText: "",
                  ),
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: AppRes.age,
                      style: TextStyle(
                        color: ColorRes.darkGrey3,
                        fontSize: 15,
                        fontFamily: "gilroy_extra_bold",
                      ),
                    ),
                    TextSpan(
                      text: " (" + AppRes.optional + ")",
                      style: TextStyle(
                        color: ColorRes.dimGrey2,
                        fontSize: 14,
                        fontFamily: 'gilroy_bold',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
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
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: AppRes.gender,
                      style: TextStyle(
                        color: ColorRes.darkGrey3,
                        fontSize: 15,
                        fontFamily: "gilroy_extra_bold",
                      ),
                    ),
                    TextSpan(
                      text: " (" + AppRes.optional + ")",
                      style: TextStyle(
                        color: ColorRes.dimGrey2,
                        fontSize: 14,
                        fontFamily: 'gilroy_bold',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
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
                      const SizedBox(height: 110),
                    ],
                  ),
                  showDropdown
                      ? Positioned(
                          top: 45,
                          left: 0,
                          child: DropDownBox(
                            gender: gender,
                            onChange: onGenderChange,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

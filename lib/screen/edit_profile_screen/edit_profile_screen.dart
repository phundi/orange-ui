import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/edit_profile_screen/edit_profile_screen_view_model.dart';
import 'package:orange_ui/screen/edit_profile_screen/widgets/image_list_area.dart';
import 'package:orange_ui/screen/edit_profile_screen/widgets/text_field_area/text_fields_area.dart';
import 'package:orange_ui/screen/edit_profile_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => EditProfileScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: GestureDetector(
            onTap: model.onAllScreenTap,
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  Column(
                    children: [
                      TopBarArea(onBackBtnTap: model.onBackBtnTap),
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: MediaQuery.of(context).size.width,
                        color: ColorRes.grey5,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              ImageListArea(
                                imageList: model.imageList,
                                onImgRemove: model.onImageRemove,
                                onAddBtnTap: model.onImageAdd,
                              ),
                              TextFieldsArea(
                                fullNameController: model.fullNameController,
                                addressController: model.addressController,
                                bioController: model.bioController,
                                ageController: model.ageController,
                                instagramController: model.instagramController,
                                youtubeController: model.youtubeController,
                                fullNameFocus: model.fullNameFocus,
                                addressFocus: model.addressFocus,
                                bioFocus: model.bioFocus,
                                ageFocus: model.ageFocus,
                                instagramFocus: model.instagramFocus,
                                youtubeFocus: model.youtubeFocus,
                                gender: model.gender,
                                onGenderTap: model.onGenderTap,
                                showDropdown: model.showDropdown,
                                onTextFieldTap: model.onAllScreenTap,
                                onPreviewTap: model.onPreviewTap,
                                onSaveTap: model.onSaveTap,
                                onGenderChange: model.onGenderChange,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  /* model.showDropdown
                      ? Positioned(
                          top: 645,
                          width: Get.width - 20,
                          child: DropDownBox(
                              gender: model.gender,
                              onChange: model.onGenderChange),
                        )
                      : const SizedBox(),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

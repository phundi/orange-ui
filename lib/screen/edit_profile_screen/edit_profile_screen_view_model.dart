import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:stacked/stacked.dart';

class EditProfileScreenViewModel extends BaseViewModel {
  void init() {
    getPrefsData();
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode bioFocus = FocusNode();
  FocusNode ageFocus = FocusNode();
  FocusNode instagramFocus = FocusNode();
  FocusNode youtubeFocus = FocusNode();

  String gender = AppRes.female;
  bool showDropdown = false;

  List<String> imageList = [];

  Future<void> getPrefsData() async {
    fullNameController.text = (await PrefService.getFullName()) ?? '';
    addressController.text = (await PrefService.getAddress()) ?? '';
    bioController.text = (await PrefService.getBioText()) ?? '';
    ageController.text = (await PrefService.getAge()).toString();
    instagramController.text = (await PrefService.getInstagramString()) ?? '';
    youtubeController.text = (await PrefService.getYoutubeString()) ?? '';
    gender = (await PrefService.getGender()) ?? '';
    imageList = (await PrefService.getProfileImageList()) ?? [];
    notifyListeners();
  }

  void onImageRemove(int index) {
    imageList.removeAt(index);
    notifyListeners();
  }

  void onImageAdd() async {}

  void onBackBtnTap() {
    Get.back();
  }

  void onAllScreenTap() {
    showDropdown = false;
    notifyListeners();
  }

  void onGenderTap() {
    addressFocus.unfocus();
    bioFocus.unfocus();
    ageFocus.unfocus();
    showDropdown = !showDropdown;
    notifyListeners();
  }

  void onGenderChange(String value) {
    gender = value;
    showDropdown = false;
    notifyListeners();
  }

  Future<void> onSaveTap() async {
    await setPrefsData();
    Get.back();
  }

  void onPreviewTap() {}

  Future<void> setPrefsData() async {
    await PrefService.setProfileImageList(imageList);
    fullNameController.text != ''
        ? await PrefService.setFullName(fullNameController.text)
        : null;
    addressController.text != ''
        ? await PrefService.setAddress(addressController.text)
        : null;
    bioController.text != ''
        ? await PrefService.setBioText(bioController.text)
        : null;
    ageController.text != ''
        ? await PrefService.setAge(int.parse(ageController.text))
        : null;
    instagramController.text != ''
        ? await PrefService.setInstagramString(instagramController.text)
        : null;
    youtubeController.text != ''
        ? await PrefService.setYoutubeString(youtubeController.text)
        : null;
    await PrefService.setGender(gender);
  }
}

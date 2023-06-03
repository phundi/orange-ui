import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/select_photo_screen/select_photo_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:stacked/stacked.dart';

class StartingProfileScreenViewModel extends BaseViewModel {
  void init() {
    getPrefsData();
  }

  TextEditingController addressController =
      TextEditingController(text: AppRes.newYorkUsa);
  TextEditingController bioController =
      TextEditingController(text: AppRes.profileBioText);
  TextEditingController ageController =
      TextEditingController(text: AppRes.twentyFour);

  FocusNode addressFocus = FocusNode();
  FocusNode bioFocus = FocusNode();
  FocusNode ageFocus = FocusNode();

  String fullName = '';
  String addressError = '';
  String bioError = '';

  String gender = AppRes.female;
  bool showDropdown = false;

  Future<void> getPrefsData() async {
    String? fName = await PrefService.getFullName();
    fullName = fName ?? '';
    notifyListeners();
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

  void onNextTap() {
    if (isValid()) {
      setPrefsData();
      Get.to(() => const SelectPhotoScreen());
    }
  }

  bool isValid() {
    int i = 0;
    if (addressController.text == '') {
      addressError = AppRes.enterAddress;
      i++;
    }
    if (bioController.text == '') {
      bioError = AppRes.enterBio;
      i++;
    }
    notifyListeners();
    return i == 0 ? true : false;
  }

  Future<void> setPrefsData() async {
    await PrefService.setAddress(addressController.text);
    await PrefService.setBioText(bioController.text);
    await PrefService.setAge(int.parse(ageController.text));
    await PrefService.setGender(gender);
    await PrefService.setLoginText(true);
  }
}

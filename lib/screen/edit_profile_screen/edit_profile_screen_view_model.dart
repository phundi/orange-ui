import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/get_interest.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class EditProfileScreenViewModel extends BaseViewModel {
  void init() {
    getEditProfileApiCall();
    getInterestApiCall();
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();

  FocusNode ageFocus = FocusNode();
  FocusNode bioFocus = FocusNode();
  FocusNode aboutFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode youtubeFocus = FocusNode();
  FocusNode facebookFocus = FocusNode();
  FocusNode fullNameFocus = FocusNode();
  FocusNode instagramFocus = FocusNode();

  List<Interest>? hobbiesList = [];
  List<String> selectedList = [];

  String latitude = '';
  String longitude = '';
  String gender = S.current.female;
  String fullNameError = '';
  String bioError = '';
  String aboutError = '';
  String addressError = '';
  String ageError = '';
  String? email;

  List<String> deleteIds = [];
  List<String> interestList = [];
  List<Images> imageList = [];
  List<File> imageFileList = [];

  bool showDropdown = false;
  bool isLoading = false;
  ImagePicker imagePicker = ImagePicker();

  void onClipTap(String value) {
    bool selected = selectedList.contains(value);
    if (selected) {
      selectedList.remove(value);
    } else {
      selectedList.add(value);
    }
    notifyListeners();
  }

  void getInterestApiCall() async {
    await PrefService.getInterest().then((value) {
      if (value != null && value.status!) {
        hobbiesList = value.data;
        notifyListeners();
      }
    }).then((value) {
      getPrefUser();
    });
  }

  void getEditProfileApiCall() {
    isLoading = true;
    ApiProvider().getProfile(userID: PrefService.userId).then((value) async {
      imageList = value?.data?.images ?? [];
      fullNameController.text = value?.data?.fullname ?? '';
      bioController.text = value?.data?.bio ?? '';
      aboutController.text = value?.data?.about ?? '';
      addressController.text = value?.data?.live ?? '';
      ageController.text = value?.data?.age?.toString() ?? '';

      gender = value?.data?.gender == 1
          ? S.current.male
          : value?.data?.gender == 2
              ? S.current.female
              : S.current.other;
      instagramController.text = value?.data?.instagram ?? '';
      facebookController.text = value?.data?.facebook ?? '';
      youtubeController.text = value?.data?.youtube ?? '';
      latitude = await PrefService.getLatitude() ?? '';
      longitude = await PrefService.getLongitude() ?? '';
      email = value?.data?.identity;
      await PrefService.saveUser(value?.data);
      isLoading = false;
      notifyListeners();
    });
  }

  void getPrefUser() {
    PrefService.getUserData().then((value) {
      List<String> interestIds = (value?.interests ?? '').split(',');
      selectedList.addAll(interestIds);
      notifyListeners();
    });
  }

  void onImageRemove(int index) {
    File? imageOne;
    for (File image in imageFileList) {
      if (image.path == imageList[index].image) {
        imageOne = image;
      }
    }
    if (imageOne != null) {
      imageFileList.remove(imageOne);
    }
    deleteIds.add(imageList[index].id.toString());
    imageList.removeAt(index);
    notifyListeners();
  }

  void onImageAdd() async {
    selectImages();
  }

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
    aboutFocus.unfocus();
    ageFocus.unfocus();
    showDropdown = !showDropdown;
    notifyListeners();
  }

  void onGenderChange(String value) {
    gender = value;
    showDropdown = false;
    notifyListeners();
  }

  void onSaveTap() {
    updateProfileApiCall();
  }

  void selectImages() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      late final Map<Permission, PermissionStatus> statusess;

      if (androidInfo.version.sdkInt <= 32) {
        statusess = await [
          Permission.storage,
        ].request();
      } else {
        statusess = await [
          Permission.photos,
        ].request();
      }

      var allAccepted = true;
      statusess.forEach((permission, status) {
        if (status != PermissionStatus.granted) {
          allAccepted = false;
        }
      });
      if (!allAccepted) {
        openAppSettings();
        return;
      }
    }

    final selectedImages =
        await imagePicker.pickMultiImage(imageQuality: quality, maxHeight: maxHeight, maxWidth: maxWidth);
    if (selectedImages.isEmpty) return;
    if (selectedImages.isNotEmpty) {
      for (XFile image in selectedImages) {
        var images = File(image.path);
        imageFileList.add(images);
        imageList.add(
          Images(id: -123, userId: PrefService.userId, image: images.path),
        );
      }
    }
    notifyListeners();
  }

  void updateProfileApiCall() {
    bool validation = isValid();
    notifyListeners();
    if (validation) {
      Loader().lottieLoader();
      ApiProvider()
          .updateProfile(
              latitude: latitude,
              longitude: longitude,
              images: imageFileList,
              bio: bioController.text.trim(),
              age: ageController.text.trim(),
              instagram: instagramController.text.trim(),
              about: aboutController.text.trim(),
              facebook: facebookController.text.trim(),
              youtube: youtubeController.text.trim(),
              live: addressController.text.trim(),
              gender: gender == S.current.male ? 1 : 2,
              fullName: fullNameController.text.trim(),
              deleteImageIds: deleteIds,
              interest: selectedList)
          .then((value) async {
        Get.back();
        Get.back();
      });
    }
  }

  bool isValid() {
    int i = 0;
    if (imageList.isEmpty) {
      if (imageFileList.isEmpty) {
        SnackBarWidget().snackBarWidget(S.current.pleaseAddAtLeastEtc);
        i++;
      }
      SnackBarWidget().snackBarWidget(S.current.imageIsEmpty);
      i++;
    }
    if (fullNameController.text == '') {
      fullNameError = S.current.enterFullName;
      i++;
    }
    if (aboutController.text == '') {
      aboutError = S.current.enterAbout;
      i++;
    }
    if (ageController.text == '') {
      ageError = S.current.enterAge;
      i++;
    } else if (int.parse(ageController.text) < 18) {
      ageFocus.requestFocus();
      SnackBarWidget.snackBar(message: S.current.youMustBe18);
      return false;
    }
    if (selectedList.isEmpty) {
      SnackBarWidget().snackBarWidget(S.current.pleaseAddAtLeastInterest);
      i++;
    }
    notifyListeners();
    return i == 0 ? true : false;
  }

  @override
  void dispose() {
    bioFocus.dispose();
    aboutFocus.dispose();
    ageFocus.dispose();
    youtubeFocus.dispose();
    addressFocus.dispose();
    fullNameFocus.dispose();
    facebookFocus.dispose();
    instagramFocus.dispose();
    fullNameController.dispose();
    addressController.dispose();
    bioController.dispose();
    aboutController.dispose();
    ageController.dispose();
    instagramController.dispose();
    facebookController.dispose();
    youtubeController.dispose();
    super.dispose();
  }

  void onTextFieldChange(String value) {
    notifyListeners();
  }
}

import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/common_ui.dart';
import 'package:orange_ui/model/setting.dart';

import 'package:orange_ui/screen/dashboard/dashboard_screen.dart';
import 'package:orange_ui/screen/get_started_screen/widget/eula_sheet.dart';
import 'package:orange_ui/screen/login_dashboard_screen/login_dashboard_screen.dart';
import 'package:orange_ui/screen/select_hobbies_screen/select_hobbies_screen.dart';
import 'package:orange_ui/screen/select_photo_screen/select_photo_screen.dart';
import 'package:orange_ui/screen/starting_profile_screen/starting_profile_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class GetStartedScreenViewModel extends BaseViewModel {
  String? currency = '';
  String? coinRate = '';
  int? minThreshold = 0;
  int screenIndex = 0;
  Appdata? settingAppData;

  void init() {
    getPref();
    settingApiCall();
    getInterest();
  }

  void getPref() {
    PrefService.getUserData().then((value) {
      if (value == null) return;
      PrefService.userId = value.id ?? -1;
      notifyListeners();
    });
  }

  void settingApiCall() async {
    ApiProvider().callPost(
        completion: (response) async {
          Setting setting = Setting.fromJson(response);
          settingAppData = setting.data?.appdata;

          notifyListeners();
          await PrefService.saveSettingData(setting.data);
        },
        url: Urls.aGetSettingData);
  }

  Future<void> screen1NextTap() async {
    bool isEulaSheetAccept = (await PrefService.getDialog('EULA')) ?? false;
    if (Platform.isIOS) {
      if (!isEulaSheetAccept) {
        eulaSheet();
      } else {
        loginToNavigateScreen();
      }
    } else {
      loginToNavigateScreen();
    }
  }

  void loginToNavigateScreen() async {
    bool isLogin = (await PrefService.getLoginText()) ?? false;
    if (isLogin) {
      ApiProvider().getProfile(userID: PrefService.userId).then(
        (value) {
          if (value?.data?.age == null) {
            Get.off(() => const StartingProfileScreen());
          } else if (value?.data?.images == null ||
              value!.data!.images.isEmpty) {
            Get.off(() => const SelectPhotoScreen());
          } else if (value.data?.interests == null ||
              value.data!.interests!.isEmpty) {
            Get.off(() => const SelectHobbiesScreen());
          } else {
            Get.off(() => const DashboardScreen());
          }
        },
      );
    } else {
      if (settingAppData?.isDating == 1) {
        screenIndex = 3;
      } else {
        screenIndex = 1;
      }
    }
    notifyListeners();
  }

  void eulaSheet() {
    Get.bottomSheet(EulaSheet(eulaAcceptClick: eulaAcceptClick),
        isScrollControlled: true, isDismissible: false);
  }

  void eulaAcceptClick() async {
    PrefService.setDialog('EULA', true);
    Get.back();
    loginToNavigateScreen();
  }

  void onSkipTap() {
    Get.off(() => const LoginDashboardScreen());
  }

  /// Explore profile
  void screen2NextTap() {
    screenIndex = 2;
    notifyListeners();
  }

  ///Nearby profiles on map
  void screen3NextTap() async {
    checkPermissionScreen3();
    notifyListeners();
  }

  ///Stream yourself
  void screen4NextTap() {
    checkPermissionsScreen4();
  }

  void checkPermissionScreen3() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }

    CommonUI.lottieLoader();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      await PrefService.setLatitude(value.latitude.toString());
      await PrefService.setLongitude(value.longitude.toString());
      Get.back();
      screenIndex = 3;
      notifyListeners();
    });
  }

  void checkPermissionsScreen4() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.photos,
      Permission.videos,
      Permission.storage,
      Permission.microphone,
      Permission.manageExternalStorage,
    ].request();
    if (statuses[Permission.camera] == PermissionStatus.denied &&
        statuses[Permission.storage] == PermissionStatus.denied &&
        statuses[Permission.microphone] == PermissionStatus.denied &&
        statuses[Permission.manageExternalStorage] == PermissionStatus.denied) {
      await openAppSettings();
    } else {
      Get.off(() => const LoginDashboardScreen());
    }
  }

  void getInterest() {
    ApiProvider().getInterest();
  }
}

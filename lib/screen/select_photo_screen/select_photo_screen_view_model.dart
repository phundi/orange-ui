import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/select_hobbies_screen/select_hobbies_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class SelectPhotoScreenViewModel extends BaseViewModel {
  void init() {
    getPrefsData();
    get4ImgFromGallery();
    pageController = PageController(initialPage: 0, viewportFraction: 1.05)
      ..addListener(() {
        onMainImageChange();
      });
  }

  late PageController pageController;
  List<String> imageList = [];

  int pageIndex = 0;
  String fullName = '';
  int age = 0;
  String address = '';
  String bioText = '';
  int currentImgIndex = 0;

  Future<void> getPrefsData() async {
    fullName = await PrefService.getFullName() ?? '';
    age = await PrefService.getAge() ?? 0;
    address = await PrefService.getAddress() ?? '';
    bioText = await PrefService.getBioText() ?? '';
    notifyListeners();
  }

  Future<void> get4ImgFromGallery() async {
    imageList.addAll([
      AssetRes.p1,
      AssetRes.p2,
      AssetRes.p3,
    ]);
    notifyListeners();
  }

  void onMainImageChange() {
    if (currentImgIndex != pageController.page!.round()) {
      currentImgIndex = pageController.page!.round();
      notifyListeners();
    }
  }

  void onImageRemove(int index) {}

  void onImageAdd() async {}

  Future<void> onPlayButtonTap() async {
    await PrefService.setProfileImageList(imageList);
    Get.to(() => const SelectHobbiesScreen());
  }
}

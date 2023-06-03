import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/person_streaming_screen/widgets/bottom_diamond_shop.dart';
import 'package:orange_ui/screen/person_streaming_screen/widgets/bottom_purchase_shit.dart';
import 'package:orange_ui/screen/premium_screen/premium_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class PersonStreamingScreenViewModel extends BaseViewModel {
  void init() {
    getValueFromPrefs();
  }

  List<Map<String, dynamic>> commentList = [
    {
      'name': "Hamza Patel - India",
      'comment': "This teacher is so so amazing, her eyes are little scary 😒",
      'image': AssetRes.profile6,
      'type': 'text',
    },
    {
      'name': "Kety Kate - South Africa",
      'comment': AssetRes.heart,
      'image': AssetRes.profile9,
      'type': 'image',
    },
    {
      'name': "Jhon Maina - USA",
      'comment': "Hello everyone ✌",
      'image': AssetRes.profile10,
      'type': 'text',
    },
    {
      'name': "Siara Andrewz - Germany",
      'comment':
          "Hey, Cuttie. See you after many days. Looking so nice dear 🔥",
      'image': AssetRes.profile11,
      'type': 'text',
    },
  ];
  String userName = '';
  List<Map<String, dynamic>> diamondList = [
    {
      'image': AssetRes.heart,
      'gems': 20,
    },
    {
      'image': AssetRes.yellowHeart,
      'gems': 30,
    },
    {
      'image': AssetRes.blueHeart,
      'gems': 20,
    },
    {
      'image': AssetRes.purpleHeart,
      'gems': 40,
    },
    {
      'image': AssetRes.lightPinkHeart,
      'gems': 50,
    },
    {
      'image': AssetRes.pinkHeart,
      'gems': 30,
    },
    {
      'image': AssetRes.redHeart1,
      'gems': 20,
    },
    {
      'image': AssetRes.redHeart2,
      'gems': 40,
    },
    {
      'image': AssetRes.redHeart3,
      'gems': 70,
    },
    {
      'image': AssetRes.redHeart4,
      'gems': 30,
    },
    {
      'image': AssetRes.redHeart5,
      'gems': 90,
    },
    {
      'image': AssetRes.redHeart6,
      'gems': 30,
    },
  ];
  List<Map<String, dynamic>> diamondPriceList = [
    {
      'diamond': 200,
      'price': 5.00,
    },
    {
      'diamond': 1000,
      'price': 20.00,
    },
    {
      'diamond': 5000,
      'price': 70.00,
    },
    {
      'diamond': 10000,
      'price': 100.00,
    },
  ];
  TextEditingController commentController = TextEditingController();
  FocusNode commentFocus = FocusNode();
  BottomController bottomController = Get.put(BottomController());

  Future<void> getValueFromPrefs() async {
    userName = (await PrefService.getFullName() ?? '');
  }

  void onViewTap() {}

  void onExitTap() {
    Get.back();
  }

  void onMoreBtnTap() {}

  void onCommentSend() {
    if (commentController.text == '') {
      return;
    }
    commentList.add({
      'name': userName,
      'comment': commentController.text,
      'image': AssetRes.profile2,
      'type': 'text',
    });
    commentController.clear();
    notifyListeners();
  }

  void onGiftGtnTap() {
    bottomController.showDiamondShop.value = false;
    Get.bottomSheet(
      Obx(() {
        if (bottomController.showDiamondShop.isFalse) {
          return BottomPurchaseShirt(
            diamondList: diamondList,
            onGemsSubmit: onGemsSubmit,
            onAddDiamonds: onAddDiamonds,
            onDiamondTap: onDiamondTap,
          );
        } else {
          return BottomDiamondShop(
            diamondList: diamondPriceList,
            onDiamondPurchase: onDiamondPurchase,
          );
        }
      }),
      isScrollControlled: true,
      barrierColor: Colors.transparent,
    ).then((value) {
      commentFocus.unfocus();
    });
  }

  void onGoPremiumTap() {
    Get.to(() => const PremiumScreen());
  }

  void onDiamondPurchase(Map<String, dynamic> data) {
    bottomController.onDiamondPurchase();
  }

  void onGemsSubmit() {}

  void onAddDiamonds() {
    bottomController.onAddDiamonds();
  }

  void onDiamondTap(Map<String, dynamic> data) {
    Get.back();
  }
}

class BottomController extends GetxController {
  Rx<bool> showDiamondShop = false.obs;

  void onAddDiamonds() {
    showDiamondShop.value = true;
  }

  void onDiamondPurchase() {
    showDiamondShop.value = false;
  }
}

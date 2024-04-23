import 'dart:io';

import 'package:bubbly_camera/bubbly_camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/common_ui.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/get_diamond_pack.dart';
import 'package:stacked/stacked.dart';

class BottomDiamondShopViewModel extends BaseViewModel {
  List<GetDiamondPackData>? diamondPriceList = [];
  int? coinValue = 100;

  void init() {
    const MethodChannel('bubbly_camera').setMethodCallHandler((call) async {
      Get.back();

      if (call.arguments == true) {
        addCoinApiCall();
      } else {
        CommonUI.snackBar(message: S.current.failedPayment);
      }
      return;
    });
    getDiamondPackApiCall();
  }

  void addCoinApiCall() {
    CommonUI.lottieLoader();
    ApiProvider().addCoinFromWallet(coinValue).then((value) {
      if (Get.isBottomSheetOpen == true) {
        Get.back();
      }
      Get.back();
    });
  }

  void getDiamondPackApiCall() {
    ApiProvider().getDiamondPack().then((value) {
      diamondPriceList = value.data;
      notifyListeners();
    });
  }

  void onDiamondPurchase(GetDiamondPackData? data) async {
    CommonUI.lottieLoader();
    coinValue = data?.amount;
    BubblyCamera.inAppPurchase(
        Platform.isAndroid ? data?.androidProductId : data?.iosProductId);
  }
}

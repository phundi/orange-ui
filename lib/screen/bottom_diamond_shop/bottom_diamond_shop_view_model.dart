import 'dart:io';

import 'package:bubbly_camera/bubbly_camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/get_diamond_pack.dart';
import 'package:stacked/stacked.dart';

class BottomDiamondShopViewModel extends BaseViewModel {
  List<GetDiamondPackData>? diamondPriceList = [];
  int? coinValue = 0;

  void init() {
    const MethodChannel('bubbly_camera').setMethodCallHandler((call) async {
      print(call);
      if (call.arguments == true) {
        addCoinApiCall(coinValue);
      } else {
        Get.back();
        SnackBarWidget.snackBar(message: S.current.failedPayment);
      }
      return;
    });
    getDiamondPackApiCall();
  }

  void addCoinApiCall(int? coinValue) {
    Loader().lottieLoader();
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
    Loader().lottieLoader();
    await BubblyCamera.inAppPurchase(
        Platform.isAndroid ? data?.androidProductId : data?.iosProductId);
    Get.back();
    coinValue = data?.amount;
  }
}

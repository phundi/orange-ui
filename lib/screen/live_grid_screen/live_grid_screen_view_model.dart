import 'package:get/get.dart';
import 'package:orange_ui/screen/person_streaming_screen/person_streaming_screen.dart';
import 'package:orange_ui/screen/random_streming_screen/random_streaming_screen.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class LiveGridScreenViewModel extends BaseViewModel {
  void init() {}

  List<Map<String, dynamic>> userData = [
    {
      'name': "Mimi Brown",
      'age': 24,
      'image': AssetRes.profile18,
      'address': "London, UK",
      'view': "15k+",
    },
    {
      'name': "Geema Ashi",
      'age': 24,
      'image': AssetRes.profile19,
      'address': "Mumbai, INDIA",
      'view': "15k+"
    },
    {
      'name': "premium ad",
      'image': AssetRes.profile21,
    },
    {
      'name': "Majd Rovio",
      'age': 24,
      'image': AssetRes.profile20,
      'address': "Dubai, UAE",
      'view': "15k+",
    },
  ];

  void onBackBtnTap() {
    Get.back();
  }

  void onGoLiveTap() {
    Get.to(() => const RandomStreamingScreen());
  }

  void onImageTap(Map<String, dynamic> data) {
    Get.to(() => const PersonStreamingScreen());
  }
}

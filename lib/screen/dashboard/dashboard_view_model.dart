import 'package:get/get.dart';
import 'package:orange_ui/screen/live_grid_screen/live_grid_screen.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends BaseViewModel {
  void init() {}

  int pageIndex = 0;

  void onBottomBarTap(int index) {
    if (index != 2) {
      pageIndex = index;
      notifyListeners();
    } else {
      Get.to(() => const LiveGridScreen());
    }
  }

  Future<bool> onBack() async {
    if (pageIndex == 0) {
      return true;
    } else {
      pageIndex = 0;
      notifyListeners();
      return false;
    }
  }
}

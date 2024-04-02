import 'package:stacked/stacked.dart';

class FollowingListScreenViewModel extends BaseViewModel {
  bool isSearching = false;

  void init() {}

  void onSearchBtnClick() {
    isSearching = !isSearching;
    notifyListeners();
  }
}

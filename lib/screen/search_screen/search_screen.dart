import 'package:flutter/material.dart';
import 'package:orange_ui/screen/search_screen/search_screen_view_model.dart';
import 'package:orange_ui/screen/search_screen/widgets/search_bar_area.dart';
import 'package:orange_ui/screen/search_screen/widgets/user_list.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => SearchScreenViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            model.onBackBtnTap();
            return false;
          },
          child: Scaffold(
            backgroundColor: ColorRes.white,
            body: Column(
              children: [
                SearchBarArea(
                  searchController: model.searchController,
                  selectedTab: model.selectedTab,
                  tabList: model.tabList,
                  onBackBtnTap: model.onBackBtnTap,
                  onSearchBtnTap: model.onSearchBtnTap,
                  onLocationTap: model.onLocationTap,
                  onTabSelect: model.onTabSelect,
                ),
                const SizedBox(height: 11),
                UserList(
                  userList: model.filterList,
                  onUserTap: model.onUserTap,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

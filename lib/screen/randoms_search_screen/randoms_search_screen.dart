import 'package:flutter/material.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/randoms_search_screen/randoms_search_screen_view_model.dart';
import 'package:orange_ui/screen/randoms_search_screen/widgets/bottom_area.dart';
import 'package:orange_ui/screen/randoms_search_screen/widgets/profile_pic_area.dart';
import 'package:orange_ui/screen/randoms_search_screen/widgets/random_search_top_bar_area.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:stacked/stacked.dart';

class RandomsSearchScreen extends StatelessWidget {
  const RandomsSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandomsSearchScreenViewModel>.reactive(
      onViewModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => RandomsSearchScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              RandomSearchTopBarArea(
                onBackBtnTap: model.onBackBtnTap,
              ),
              const SizedBox(height: 27),
              ProfilePicArea(
                isLoading: model.isLoading,
                userData: model.userData,
                pageController: model.pageController,
                onLeftBtnClick: model.onLeftBtnClick,
                onRightBtnClick: model.onRightBtnClick,
                onYoutubeTap: model.onYoutubeTap,
                onFacebookTap: model.onFBTap,
                onInstagramTap: model.onInstagramTap,
                onLiveBtnTap: model.onLiveBtnTap,
                onImageTap: model.onImageTap,
                isSocialBtnVisible: model.isSocialBtnVisible,
              ),
              Visibility(
                visible: model.isLoading == true ? true : false,
                child: Text(
                  S.current.searching,
                  style: const TextStyle(
                    fontFamily: FontRes.bold,
                    fontSize: 22,
                    color: ColorRes.darkGrey7,
                  ),
                ),
              ),
              const Spacer(),
              BottomArea(
                onCancelTap: model.onCancelTap,
                onNextTap: model.onNextTap,
                isLoading: model.isLoading,
              ),
            ],
          ),
        );
      },
    );
  }
}

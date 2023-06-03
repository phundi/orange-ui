import 'package:flutter/material.dart';
import 'package:orange_ui/screen/randoms_search_screen/randoms_search_screen_view_model.dart';
import 'package:orange_ui/screen/randoms_search_screen/widgets/bottom_area.dart';
import 'package:orange_ui/screen/randoms_search_screen/widgets/profile_pic_area.dart';
import 'package:orange_ui/screen/randoms_search_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class RandomsSearchScreen extends StatelessWidget {
  const RandomsSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandomsSearchScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => RandomsSearchScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              TopBarArea(
                onBackBtnTap: model.onBackBtnTap,
              ),
              const SizedBox(height: 27),
              ProfilePicArea(image: model.image),
              const Spacer(),
              BottomArea(
                onSearchingTextTap: model.onSearchingTextTap,
                onCancelTap: model.onCancelTap,
              ),
            ],
          ),
        );
      },
    );
  }
}

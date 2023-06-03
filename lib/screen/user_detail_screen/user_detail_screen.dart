import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen_view_model.dart';
import 'package:orange_ui/screen/user_detail_screen/widgets/detail_page.dart';
import 'package:orange_ui/screen/user_detail_screen/widgets/image_selection_area.dart';
import 'package:orange_ui/screen/user_detail_screen/widgets/top_bar.dart';
import 'package:stacked/stacked.dart';

class UserDetailScreen extends StatelessWidget {
  final bool? showInfo;

  const UserDetailScreen({Key? key, this.showInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserDetailScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init(showInfo);
      },
      viewModelBuilder: () => UserDetailScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(model.imageList[model.selectedImgIndex]),
              ),
            ),
            child: Column(
              children: [
                TopBar(
                  onBackTap: model.onBackTap,
                  onMoreBtnTap: model.onMoreBtnTap,
                ),
                !model.moreInfo
                    ? ImageSelectionArea(
                        selectedImgIndex: model.selectedImgIndex,
                        imageList: model.imageList,
                        like: model.like,
                        onImgSelect: model.onImageSelect,
                        onJoinBtnTap: model.onJoinBtnTap,
                        onMoreInfoTap: model.onMoreInfoTap,
                        onLikeBtnTap: model.onLikeBtnTap,
                      )
                    : DetailPage(
                        save: model.save,
                        interestList: model.interestList,
                        onHideBtnTap: model.onHideInfoTap,
                        onSaveTap: model.onSaveTap,
                        onChatWithTap: model.onChatWithBtnTap,
                        onShareWithTap: model.onShareProfileBtnTap,
                        onReportTap: model.onReportTap,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

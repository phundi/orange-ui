import 'package:flutter/material.dart';
import 'package:orange_ui/screen/profile_screen/profile_screen_view_model.dart';
import 'package:orange_ui/screen/profile_screen/widget/profile_images_area.dart';
import 'package:orange_ui/screen/profile_screen/widget/profile_top_area.dart';
import 'package:stacked/stacked.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => ProfileScreenViewModel(),
      builder: (context, model, child) {
        return SizedBox(
          child: Column(
            children: [
              ProfileTopArea(
                onNotificationTap: model.onNotificationTap,
                onSearchTap: model.onSearchBtnTap,
              ),
              ProfileImageArea(
                imageList: model.imageList,
                pageController: model.pageController,
                onEditProfileTap: model.onEditProfileTap,
                onMoreBtnTap: model.onMoreBtnTap,
                onImageTap: model.onImageTap,
                fullName: model.userName,
                age: model.age,
                address: model.address,
                bioText: model.bioText,
              ),
            ],
          ),
        );
      },
    );
  }
}

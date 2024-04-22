import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/common_ui.dart';

import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/following_list_screen/follow_following_screen_view_model.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:stacked/stacked.dart';

class FollowFollowingScreen extends StatelessWidget {
  final FollowFollowingType followFollowingType;
  final int userId;

  const FollowFollowingScreen(
      {Key? key, required this.followFollowingType, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FollowFollowingScreenViewModel>.reactive(
      viewModelBuilder: () =>
          FollowFollowingScreenViewModel(followFollowingType, userId),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              SafeArea(
                bottom: false,
                child: Container(
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back,
                              color: ColorRes.veryDarkGrey4)),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).followingList,
                          style: const TextStyle(
                              color: ColorRes.veryDarkGrey4,
                              fontFamily: FontRes.semiBold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: viewModel.isLoading
                    ? CommonUI.lottieWidget()
                    : viewModel.users.isEmpty
                        ? CommonUI.noData()
                        : ListView.builder(
                            controller: viewModel.scrollController,
                            itemCount: viewModel.users.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              RegistrationUserData user =
                                  viewModel.users[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: ShapeDecoration(
                                  shape: SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius(
                                          cornerRadius: 12,
                                          cornerSmoothing: 1)),
                                  color: ColorRes.lightGrey2,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius: SmoothBorderRadius(
                                            cornerRadius: 7,
                                            cornerSmoothing: 1),
                                        child: CachedNetworkImage(
                                          imageUrl: CommonFun.getProfileImage(
                                              images: user.images),
                                          cacheKey: CommonFun.getProfileImage(
                                              images: user.images),
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) {
                                            return CommonUI
                                                .profileImagePlaceHolder(
                                                    name: user.fullname,
                                                    borderRadius: 7,
                                                    heightWeight: 50);
                                          },
                                        )),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  CommonUI.fullName(
                                                      user.fullname),
                                                  style: const TextStyle(
                                                      fontFamily: FontRes.bold,
                                                      fontSize: 18,
                                                      color:
                                                          ColorRes.darkGrey4),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(' ${user.age ?? 0} ',
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          FontRes.regular,
                                                      color: ColorRes.darkGrey4,
                                                      fontSize: 18)),
                                              user.isVerified == 0
                                                  ? const SizedBox()
                                                  : Image.asset(
                                                      AssetRes.icBlueTick,
                                                      width: 18,
                                                    )
                                            ],
                                          ),
                                          Text(
                                            user.live ?? '',
                                            style: const TextStyle(
                                                color: ColorRes.grey6,
                                                fontFamily: FontRes.regular,
                                                fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
              )
            ],
          ),
        );
      },
    );
  }
}

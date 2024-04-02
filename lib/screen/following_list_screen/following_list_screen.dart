import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/following_list_screen/following_list_screen_view_model.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:stacked/stacked.dart';

class FollowingListScreen extends StatelessWidget {
  const FollowingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FollowingListScreenViewModel>.reactive(
      viewModelBuilder: () => FollowingListScreenViewModel(),
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
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back, color: ColorRes.veryDarkGrey4)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: viewModel.isSearching
                            ? Container(
                                decoration: ShapeDecoration(
                                    shape:
                                        SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)),
                                    color: ColorRes.greyShade200),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                    hintText: S.of(context).searchProfile,
                                    hintStyle: const TextStyle(color: ColorRes.dimGrey3),
                                  ),
                                  style: const TextStyle(color: ColorRes.lightGrey4, fontFamily: FontRes.medium),
                                  cursorHeight: 14,
                                ),
                              )
                            : Text(
                                S.of(context).followingList,
                                style: const TextStyle(
                                    color: ColorRes.veryDarkGrey4, fontFamily: FontRes.semiBold, fontSize: 18),
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: viewModel.onSearchBtnClick,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 37,
                          width: 37,
                          decoration:
                              BoxDecoration(color: ColorRes.orange3.withOpacity(0.1), shape: BoxShape.circle),
                          child: Center(
                            child: Image.asset(AssetRes.search, height: 20, width: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(cornerRadius: 12, cornerSmoothing: 1)),
                      color: ColorRes.lightGrey2,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: SmoothBorderRadius(cornerRadius: 7, cornerSmoothing: 1),
                            child: Image.asset(
                              AssetRes.icImage2,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Flexible(
                                    child: Text(
                                      'Natalia Nora',
                                      style: TextStyle(
                                          fontFamily: FontRes.bold, fontSize: 18, color: ColorRes.darkGrey4),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Text(' 24 ',
                                      style: TextStyle(
                                          fontFamily: FontRes.regular, color: ColorRes.darkGrey4, fontSize: 18)),
                                  Image.asset(
                                    AssetRes.icBlueTick,
                                    width: 18,
                                  )
                                ],
                              ),
                              const Text(
                                'Las Vegas, USA',
                                style: TextStyle(color: ColorRes.grey6, fontFamily: FontRes.regular, fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

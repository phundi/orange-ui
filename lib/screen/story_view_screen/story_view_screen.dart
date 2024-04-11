import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/story_view_screen/story_view_screen_view_model.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:stacked/stacked.dart';
import 'package:story_view/story_view.dart';

class StoryViewScreen extends StatelessWidget {
  const StoryViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StoryViewScreenViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      viewModelBuilder: () => StoryViewScreenViewModel(),
      builder: (context, model, child) {
        return SafeArea(
          bottom: false,
          child: Container(
            margin: EdgeInsets.only(top: AppBar().preferredSize.height),
            child: PageView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      StoryView(
                        storyItems: model.storyItems,
                        controller: model.storyController,
                        repeat: true,
                        indicatorHeight: IndicatorHeight.medium,
                        onStoryShow: (storyItem, index) {},
                        onComplete: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: SmoothBorderRadius(cornerRadius: 30),
                              child: Image.asset(
                                AssetRes.icImage2,
                                width: 35,
                                height: 35,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                children: [
                                  const Flexible(
                                      child: Text(
                                    '@shirley_setia',
                                    style: TextStyle(fontFamily: FontRes.bold, color: ColorRes.white, fontSize: 15),
                                  )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    color: ColorRes.white.withOpacity(0.7),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text('33 mins', style: TextStyle(fontFamily: FontRes.regular, fontSize: 13, color: ColorRes.white)),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: ShapeDecoration(shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)), color: ColorRes.white),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AssetRes.icEyeBlack,
                                    width: 16,
                                  ),
                                  Text(
                                    ' ${NumberFormat.compact().format(50500)}',
                                    style: const TextStyle(fontFamily: FontRes.medium, fontSize: 12, color: ColorRes.black),
                                  )
                                ],
                              ),
                            ),
                            PopupMenuButton(
                              onSelected: (value) {},
                              padding: EdgeInsets.zero,
                              itemBuilder: (context) {
                                return <PopupMenuEntry>[
                                  PopupMenuItem(
                                    value: 'Share',
                                    padding: const EdgeInsets.symmetric(vertical: 0),
                                    child: Center(
                                      child: Text(
                                        S.of(context).share.capitalize ?? '',
                                        style: const TextStyle(fontFamily: FontRes.medium, fontSize: 15, color: ColorRes.dimGrey3),
                                      ),
                                    ),
                                  ),
                                  const PopupMenuItem(height: 1, padding: EdgeInsets.zero, child: Divider(height: 1, thickness: 1, color: ColorRes.greyShade200)),
                                  PopupMenuItem(
                                    value: 'Delete',
                                    child: Center(
                                      child: Text(
                                        S.of(context).delete,
                                        style: const TextStyle(fontFamily: FontRes.medium, fontSize: 15, color: ColorRes.orange2),
                                      ),
                                    ),
                                  ),
                                ];
                              },
                              shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 6, cornerSmoothing: 1), side: const BorderSide(color: ColorRes.greyShade200)),
                              surfaceTintColor: ColorRes.white,
                              color: ColorRes.white,
                              position: PopupMenuPosition.under,
                              child: Image.asset(
                                AssetRes.icHorizontalThreeDot,
                                height: 20,
                                width: 20,
                                color: ColorRes.white,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}

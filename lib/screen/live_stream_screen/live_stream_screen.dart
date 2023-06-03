import 'package:flutter/material.dart';
import 'package:orange_ui/screen/live_stream_screen/widgets/center_area_livestream.dart';
import 'package:orange_ui/screen/live_stream_screen/widgets/live_strream_top_area.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

import 'live_stream_screen_view_model.dart';

class LiveStreamScreen extends StatelessWidget {
  const LiveStreamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LiveStreamScreenViewModel>.reactive(
        onModelReady: (model) {
          model.init();
        },
        viewModelBuilder: () => LiveStreamScreenViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: ColorRes.white,
            body: Column(
              children: [
                LiveStreamTopArea(onBackBtnTap: model.onBackBtnTap),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: MediaQuery.of(context).size.width,
                  color: ColorRes.grey5,
                ),
                CenterAreaLiveStream(
                  aboutController: model.aboutController,
                  languageController: model.languageController,
                  link1Controller: model.link1Controller,
                  link2Controller: model.link2Controller,
                  onSubmitTap: model.onSubmitBtnTap,
                  videoController: model.videoController,
                  onAddBtnTap: model.onPlusBtnTap,
                  onRemoveBtnTap: model.onRemoveBtnTap,
                  onVideoControllerChange: model.onVideoControllerChange,
                ),
              ],
            ),
          );
        });
  }
}

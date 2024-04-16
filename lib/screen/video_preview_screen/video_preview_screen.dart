import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/video_preview_screen/video_preview_screen_view_model.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatelessWidget {
  final String? videoUrl;

  const VideoPreviewScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorRes.black,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
    );
    return ViewModelBuilder<VideoPlayerScreenViewModel>.reactive(
      onViewModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => VideoPlayerScreenViewModel(videoUrl),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.black,
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: model.isExceptionError
                      ? Text(
                          S.current.failedToLoadVideo,
                          style: const TextStyle(color: ColorRes.white),
                        )
                      : InkWell(
                          onTap: model.onPlayPauseTap,
                          child: AspectRatio(
                            aspectRatio: model.videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(model.videoPlayerController),
                          ),
                        ),
                ),
                ValueListenableBuilder(
                    valueListenable: model.videoPlayerController,
                    builder: (context, VideoPlayerValue value, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: model.onBackBtnTap,
                              child: Container(
                                height: 37,
                                width: 37,
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                decoration: const BoxDecoration(color: ColorRes.black, shape: BoxShape.circle),
                                child: Center(
                                    child: Image.asset(
                                  AssetRes.backArrow,
                                  height: 20,
                                  width: 20,
                                  color: ColorRes.white,
                                )),
                              ),
                            ),
                          ),
                          model.isExceptionError
                              ? const SizedBox()
                              : AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: value.isPlaying ? 0.0 : 1.0,
                                  child: InkWell(
                                    onTap: model.onPlayPauseTap,
                                    child: Container(
                                      width: 55,
                                      height: 55,
                                      margin: const EdgeInsets.all(10),
                                      decoration: ShapeDecoration(
                                          shape:
                                              SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)),
                                          color: ColorRes.black.withOpacity(0.4)),
                                      alignment: Alignment.center,
                                      child: Image.asset(value.isPlaying ? AssetRes.icPause : AssetRes.icPlay,
                                          color: ColorRes.white,
                                          width: 20,
                                          height: 20,
                                          alignment: Alignment.centerRight),
                                    ),
                                  ),
                                ),
                          model.isExceptionError
                              ? const SizedBox()
                              : Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${CommonFun.printDuration(value.position)} / ${CommonFun.printDuration(value.duration)}',
                                        style: const TextStyle(color: ColorRes.white, fontFamily: FontRes.medium),
                                      ),
                                      VideoProgressIndicator(
                                        model.videoPlayerController,
                                        allowScrubbing: true,
                                        padding: const EdgeInsets.only(bottom: 15, top: 3),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}

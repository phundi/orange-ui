import 'package:camera/camera.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/common_fun.dart';
import 'package:orange_ui/common/common_ui.dart';
import 'package:orange_ui/screen/camera_screen/camera_screen_view_model.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:stacked/stacked.dart';

class CameraScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CameraScreenViewModel>.reactive(
        onViewModelReady: (viewModel) => viewModel.init(),
        viewModelBuilder: () => CameraScreenViewModel(cameras),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: ColorRes.black,
            body: ClipRRect(
              child: Stack(
                children: [
                  viewModel.isLoading
                      ? CommonUI.lottieWidget()
                      : viewModel.cameraController.value.isInitialized
                          ? Transform.scale(
                              scale: 1 /
                                  ((viewModel
                                          .cameraController.value.aspectRatio) *
                                      MediaQuery.of(context).size.aspectRatio),
                              alignment: Alignment.topCenter,
                              child: CameraPreview(viewModel.cameraController))
                          : Align(
                              alignment: Alignment.center,
                              child: CommonUI.lottieWidget()),
                  SafeArea(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.all(15),
                            ),
                            const Spacer(),
                            Obx(
                              () => viewModel.currentTime.value.isEmpty
                                  ? const SizedBox()
                                  : Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      margin: const EdgeInsets.all(15),
                                      decoration: ShapeDecoration(
                                          shape: SmoothRectangleBorder(
                                              borderRadius: SmoothBorderRadius(
                                                  cornerRadius: 10)),
                                          color: ColorRes.red),
                                      alignment: Alignment.center,
                                      child: Text(
                                        CommonFun.formatHHMMSS(int.parse(
                                            viewModel.currentTime.value)),
                                        style: const TextStyle(
                                            color: ColorRes.white,
                                            fontFamily: FontRes.medium,
                                            fontSize: 15),
                                      ),
                                    ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                margin: const EdgeInsets.all(15),
                                decoration: ShapeDecoration(
                                    shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                            cornerRadius: 30)),
                                    color: ColorRes.white.withOpacity(0.4)),
                                alignment: Alignment.center,
                                child: const Icon(Icons.close_rounded,
                                    color: ColorRes.white, size: 30),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: viewModel.onMediaTap,
                              child: Image.asset(AssetRes.icMedia,
                                  width: 30, height: 30),
                            ),
                            GestureDetector(
                              onTap: viewModel.captureImage,
                              onLongPressStart: viewModel.onCaptureVideoStart,
                              onLongPressEnd: viewModel.onCaptureVideoEnd,
                              child: Container(
                                height: 75,
                                width: 75,
                                decoration: ShapeDecoration(
                                    shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                            cornerRadius: 50),
                                        side: const BorderSide(
                                            color: ColorRes.white, width: 4))),
                                alignment: Alignment.center,
                                child: Container(
                                  width: 62,
                                  height: 62,
                                  decoration: ShapeDecoration(
                                      shape: SmoothRectangleBorder(
                                          borderRadius: SmoothBorderRadius(
                                              cornerRadius: 50)),
                                      color: ColorRes.white),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: viewModel.onCameraFlip,
                              child: Image.asset(AssetRes.icCameraFlip,
                                  width: 30, height: 30),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

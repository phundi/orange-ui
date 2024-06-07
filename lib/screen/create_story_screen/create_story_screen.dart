import 'package:camera/camera.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/common/common_fun.dart';
import 'package:orange_ui/common/common_ui.dart';
import 'package:orange_ui/screen/create_story_screen/create_story_screen_view_model.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class CreateStoryScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  const CreateStoryScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateStoryScreenViewModel>.reactive(
        onViewModelReady: (viewModel) => viewModel.init(),
        viewModelBuilder: () => CreateStoryScreenViewModel(cameras),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: ColorRes.black,
            body: ClipRRect(
              child: Stack(
                children: [
                  viewModel.isLoading
                      ? CommonUI.lottieWidget()
                      : viewModel.cameraController != null
                          ? Transform.scale(
                              scale: 1 /
                                  ((viewModel.cameraController!.value.aspectRatio) *
                                      MediaQuery.of(context).size.aspectRatio),
                              alignment: Alignment.topCenter,
                              child: CameraPreview(viewModel.cameraController!))
                          : Align(alignment: Alignment.center, child: CommonUI.lottieWidget()),
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
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      margin: const EdgeInsets.all(15),
                                      decoration: ShapeDecoration(
                                          shape: SmoothRectangleBorder(
                                              borderRadius: SmoothBorderRadius(cornerRadius: 10)),
                                          color: ColorRes.darkOrange),
                                      alignment: Alignment.center,
                                      child: Text(
                                        CommonFun.formatHHMMSS(
                                            int.parse(viewModel.currentTime.value)),
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
                                        borderRadius: SmoothBorderRadius(cornerRadius: 30)),
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
                              child: Image.asset(AssetRes.icMedia, width: 30, height: 30),
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
                                        borderRadius: SmoothBorderRadius(cornerRadius: 50),
                                        side: const BorderSide(color: ColorRes.white, width: 4))),
                                alignment: Alignment.center,
                                child: Container(
                                  width: 62,
                                  height: 62,
                                  decoration: ShapeDecoration(
                                      shape: SmoothRectangleBorder(
                                          borderRadius: SmoothBorderRadius(cornerRadius: 50)),
                                      color: ColorRes.white),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: viewModel.onCameraFlip,
                              child: Image.asset(AssetRes.icCameraFlip, width: 30, height: 30),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  if (viewModel.isPermissionNotGranted)
                    PermissionNotGrantedWidget(viewModel: viewModel)
                ],
              ),
            ),
          );
        });
  }
}

class PermissionNotGrantedWidget extends StatelessWidget {
  final CreateStoryScreenViewModel viewModel;

  const PermissionNotGrantedWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: ColorRes.black,
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                      shape:
                          SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)),
                      color: ColorRes.white.withOpacity(0.4)),
                  alignment: Alignment.center,
                  child: const Icon(Icons.close_rounded, color: ColorRes.white, size: 30),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: RichText(
                text: const TextSpan(
                  text: 'Allow ',
                  children: [
                    TextSpan(
                        text: appName,
                        style: TextStyle(
                            color: ColorRes.darkOrange, fontFamily: FontRes.bold, fontSize: 17)),
                    TextSpan(text: ' to access your camera and microphone')
                  ],
                  style: TextStyle(
                    fontFamily: FontRes.semiBold,
                    fontSize: 20,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'If appears that camera permission has not been granted. To the App, you'
                '\'ll need to allow access to the camera from the settings.',
                style: TextStyle(fontFamily: FontRes.regular, color: ColorRes.white),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                openAppSettings();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Open Settings',
                  style: TextStyle(
                      color: ColorRes.darkOrange, fontFamily: FontRes.semiBold, fontSize: 15),
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: InkWell(
                  onTap: viewModel.onMediaTap,
                  child: Image.asset(AssetRes.icMedia, width: 30, height: 30),
                ),
              ),
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}

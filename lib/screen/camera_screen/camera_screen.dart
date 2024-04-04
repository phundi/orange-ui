import 'package:camera/camera.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/screen/camera_screen/camera_screen_view_model.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CameraScreenViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      viewModelBuilder: () => CameraScreenViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Stack(
          children: [
            viewModel.controller.value.isInitialized
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FittedBox(fit: BoxFit.cover, child: SizedBox(width: 100, child: CameraPreview(viewModel.controller))),
                  )
                : Align(alignment: Alignment.center, child: Loader().lottieWidget()),
            SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      decoration: ShapeDecoration(shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 30)), color: ColorRes.white.withOpacity(0.4)),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(
                        Icons.close_rounded,
                        color: ColorRes.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        AssetRes.icMedia,
                        width: 30,
                        height: 30,
                      ),
                      InkWell(
                        onTap: viewModel.captureImage,
                        child: Container(
                          height: 75,
                          width: 75,
                          decoration: ShapeDecoration(
                            shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 50), side: const BorderSide(color: ColorRes.white, width: 4)),
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            width: 62,
                            height: 62,
                            decoration: ShapeDecoration(shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 50)), color: ColorRes.white),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: viewModel.onCameraFlip,
                        child: Image.asset(
                          AssetRes.icCameraFlip,
                          width: 30,
                          height: 30,
                        ),
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
  }
}

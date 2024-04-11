import 'dart:io';

import 'package:camera/camera.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/style_res.dart';

class CameraPreviewScreen extends StatelessWidget {
  final XFile xFile;

  const CameraPreviewScreen({Key? key, required this.xFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.file(File(xFile.path), height: double.infinity, width: double.infinity, fit: BoxFit.cover),
          SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 50)),
                      gradient: StyleRes.linearGradient),
                  child: const Icon(Icons.close, color: ColorRes.white, size: 25),
                ),
              ),
            ),
          ),
          Image.asset(AssetRes.icBlackBgShadow,
              height: 200, width: double.infinity, fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.only(bottom: AppBar().preferredSize.height / 2),
              decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: 50)),
                  gradient: StyleRes.linearGradient),
              child: const Icon(Icons.check_rounded, color: ColorRes.white, size: 32),
            ),
          )
        ],
      ),
    );
  }
}

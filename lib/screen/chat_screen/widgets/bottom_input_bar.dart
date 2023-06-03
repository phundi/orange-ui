import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class BottomInputBar extends StatelessWidget {
  final TextEditingController msgController;
  final VoidCallback onShareBtnTap;
  final VoidCallback onAddBtnTap;
  final VoidCallback onCameraTap;

  const BottomInputBar({
    Key? key,
    required this.msgController,
    required this.onShareBtnTap,
    required this.onAddBtnTap,
    required this.onCameraTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      width: Get.width,
      color: ColorRes.white,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorRes.grey10,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width - 135,
                    child: TextField(
                      controller: msgController,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 15, bottom: 3),
                        border: InputBorder.none,
                        hintText: AppRes.chatHint,
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onShareBtnTap,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 36,
                      width: 36,
                      alignment: const AlignmentDirectional(0.2, 0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorRes.lightOrange1,
                            ColorRes.darkOrange,
                          ],
                        ),
                      ),
                      child: Image.asset(AssetRes.share,
                          height: 16.5, width: 16.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.5),
            InkWell(
              onTap: onAddBtnTap,
              child: Image.asset(AssetRes.add, height: 25, width: 25),
            ),
            const SizedBox(width: 13.5),
            InkWell(
              onTap: onCameraTap,
              child: Image.asset(AssetRes.camera, height: 18, width: 24),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

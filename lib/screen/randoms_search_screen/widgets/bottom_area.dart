import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class BottomArea extends StatelessWidget {
  final VoidCallback onSearchingTextTap;
  final VoidCallback onCancelTap;

  const BottomArea({
    Key? key,
    required this.onSearchingTextTap,
    required this.onCancelTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34.0),
            child: InkWell(
              onTap: onSearchingTextTap,
              child: const Text(
                AppRes.randomSearchingText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: ColorRes.darkGrey8,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            AppRes.searching,
            style: TextStyle(
              fontFamily: 'gilroy_bold',
              fontSize: 22,
              color: ColorRes.darkGrey7,
            ),
          ),
          const SizedBox(height: 23),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onCancelTap,
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.orange3.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    AppRes.cancelCap,
                    style: TextStyle(
                      color: ColorRes.orange3,
                      fontFamily: 'gilroy_bold',
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 23),
        ],
      ),
    );
  }
}

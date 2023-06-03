import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/asset_res.dart';

class TopArea extends StatelessWidget {
  final String notification;
  final VoidCallback onBack;

  const TopArea({
    Key? key,
    required this.notification,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 40, 0, 17),
      child: Stack(
        children: [
          SizedBox(
            width: Get.width,
            height: 37,
            child: Center(
              child: Text(
                notification,
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: "gilroy_bold",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23.0),
            child: InkWell(
              onTap: onBack,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 37,
                width: 37,
                padding: const EdgeInsets.only(right: 3),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetRes.backButton),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    AssetRes.backArrow,
                    height: 14,
                    width: 7,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class ProfilePicArea extends StatelessWidget {
  final String image;

  const ProfilePicArea({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height / 2,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AssetRes.worldMap),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SpinKitRipple(
            borderWidth: 100,
            duration: const Duration(milliseconds: 1500),
            size: Get.width / 1.1,
            //color: ColorRes.o,
            itemBuilder: (BuildContext context, int index) {
              return CircleAvatar(
                backgroundColor: ColorRes.grey21.withOpacity(0.40),
              );
            },
          ),
          SpinKitRipple(
            borderWidth: 50,
            duration: const Duration(milliseconds: 1500),
            size: Get.width / 1.5,
            //color: ColorRes.o,
            itemBuilder: (BuildContext context, int index) {
              return CircleAvatar(
                backgroundColor: ColorRes.grey21.withOpacity(0.30),
              );
            },
          ),
          Container(
            height: Get.width / 3,
            width: Get.width / 3,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

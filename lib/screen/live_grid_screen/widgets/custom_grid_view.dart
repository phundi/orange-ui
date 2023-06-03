import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class CustomGridView extends StatelessWidget {
  final List<Map<String, dynamic>> userData;
  final Function(Map<String, dynamic> data) onImageTap;

  const CustomGridView({
    Key? key,
    required this.userData,
    required this.onImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: userData.map<Widget>((e) {
                int index = userData.indexOf(e);
                return index % 2 == 0
                    ? gridTile(
                        data: e,
                        width: (Get.width / 2) - 18,
                        height: index % 4 == 0
                            ? (Get.width * 0.65)
                            : (Get.width * 0.49),
                        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      )
                    : const SizedBox();
              }).toList(),
            ),
            Column(
              children: userData.map<Widget>((e) {
                int index = userData.indexOf(e);
                return index % 2 == 1
                    ? gridTile(
                        data: e,
                        width: (Get.width / 2) - 18,
                        height: (index + 1) % 4 == 0
                            ? (Get.width * 0.65)
                            : (Get.width * 0.49),
                        margin: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                      )
                    : const SizedBox();
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridTile({
    required Map<String, dynamic> data,
    required double height,
    required double width,
    required EdgeInsetsGeometry margin,
  }) {
    return GestureDetector(
      onTap: () {
        onImageTap(data);
      },
      child: Container(
        width: width,
        height: height,
        margin: margin,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(data['image']),
          ),
        ),
        child: data['name'] != "premium ad"
            ? ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                  child: Container(
                    width: width,
                    color: ColorRes.grey29.withOpacity(0.20),
                    padding: EdgeInsets.fromLTRB(Get.width / 40, 12, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              data['name'],
                              style: const TextStyle(
                                color: ColorRes.white,
                                fontSize: 15,
                                fontFamily: 'gilroy_bold',
                              ),
                            ),
                            Text(
                              " ${data['age']}",
                              style: const TextStyle(
                                color: ColorRes.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Image.asset(
                              AssetRes.tickMark,
                              height: 16,
                              width: 16,
                            ),
                          ],
                        ),
                        Text(
                          data['address'],
                          style: const TextStyle(
                            color: ColorRes.white,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              AssetRes.eye,
                              width: 15,
                              height: 12,
                              color: ColorRes.white,
                            ),
                            const SizedBox(width: 3.5),
                            Text(
                              data['view'],
                              style: const TextStyle(
                                color: ColorRes.white,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : premiumBox(),
      ),
    );
  }

  Widget premiumBox() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 12, sigmaX: 12),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: ColorRes.grey29.withOpacity(0.20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(AssetRes.premiumCrown, height: 51, width: 51),
              Column(
                children: const [
                  Text(
                    AppRes.subscribeToPro,
                    style: TextStyle(
                      color: ColorRes.white,
                      fontFamily: 'gilroy_bold',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    AppRes.enjoyLimitedEtc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorRes.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Container(
                height: 31,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ColorRes.white.withOpacity(0.10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      AppRes.go,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      AppRes.premium,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 12,
                        fontFamily: 'gilroy_bold',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

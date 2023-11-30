import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onBackTap;
  final Function(String value) onMoreBtnTap;
  final String? fullName;
  final String? age;
  final bool isVerified;
  final String blockUnblock;
  final RegistrationUserData? userData;
  final bool moreInfo;

  const TopBar(
      {Key? key,
      required this.onBackTap,
      required this.onMoreBtnTap,
      required this.fullName,
      required this.age,
      required this.isVerified,
      required this.blockUnblock,
      this.userData,
      required this.moreInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: SafeArea(
        bottom: false,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: ColorRes.black.withOpacity(0.33),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                children: [
                  InkWell(
                    onTap: onBackTap,
                    child: Image.asset(
                      AssetRes.backArrow,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            fullName ?? 'Unknown',
                            style: const TextStyle(
                              color: ColorRes.white,
                              fontSize: 16,
                              fontFamily: FontRes.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          ' $age ',
                          style: const TextStyle(
                            color: ColorRes.white,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Visibility(
                          visible: isVerified,
                          child: Image.asset(AssetRes.tickMark,
                              height: 16, width: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Visibility(
                    visible: PrefService.userId == userData?.id ? false : true,
                    child: Visibility(
                      visible: moreInfo == true ? false : true,
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          onMoreBtnTap(value);
                        },
                        color: ColorRes.black2.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        itemBuilder: (BuildContext context) {
                          return {blockUnblock, AppRes.report}.map(
                            (String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                textStyle: const TextStyle(
                                    fontFamily: FontRes.medium,
                                    color: ColorRes.white),
                                child: Text(
                                  choice,
                                  style: const TextStyle(
                                      fontFamily: FontRes.medium,
                                      color: ColorRes.white),
                                ),
                              );
                            },
                          ).toList();
                        },
                        child: Image.asset(
                          AssetRes.moreHorizontal,
                          height: 10,
                          width: 26.74,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class DetailPage extends StatelessWidget {
  final bool save;
  final List<String> interestList;
  final VoidCallback onHideBtnTap;
  final VoidCallback onSaveTap;
  final VoidCallback onChatWithTap;
  final VoidCallback onShareWithTap;
  final VoidCallback onReportTap;

  const DetailPage({
    Key? key,
    required this.save,
    required this.interestList,
    required this.onHideBtnTap,
    required this.onSaveTap,
    required this.onChatWithTap,
    required this.onShareWithTap,
    required this.onReportTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 101,
      width: Get.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                child: Container(
                  width: Get.width,
                  height: Get.height - 116,
                  padding: const EdgeInsets.fromLTRB(21, 20, 21, 0),
                  decoration: BoxDecoration(
                    color: ColorRes.black.withOpacity(0.33),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text(
                              AppRes.nataliaNora,
                              style: TextStyle(
                                color: ColorRes.white,
                                fontSize: 22,
                                fontFamily: 'gilroy_bold',
                              ),
                            ),
                            const Text(
                              " ${AppRes.twentyFour}",
                              style: TextStyle(
                                color: ColorRes.white,
                                fontSize: 22,
                                fontFamily: 'gilroy',
                              ),
                            ),
                            const SizedBox(width: 5),
                            Image.asset(
                              AssetRes.tickMark,
                              height: 20,
                              width: 20,
                            ),
                            const Spacer(),
                            InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: onSaveTap,
                              child: Container(
                                height: 37,
                                width: 37,
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: ColorRes.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  AssetRes.save,
                                  color: save
                                      ? null
                                      : ColorRes.dimGrey5.withOpacity(0.70),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          AppRes.profileBioText,
                          style: TextStyle(
                            color: ColorRes.white.withOpacity(0.80),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    height: 27,
                                    width: 27,
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: ColorRes.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(AssetRes.home),
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    AppRes.newYorkUsa,
                                    style: TextStyle(
                                      color: ColorRes.white.withOpacity(0.80),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    height: 27,
                                    width: 27,
                                    padding: const EdgeInsets.all(6.5),
                                    decoration: const BoxDecoration(
                                      color: ColorRes.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      AssetRes.locationPin,
                                      color: ColorRes.darkOrange,
                                      height: 12.25,
                                      width: 10.5,
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    AppRes.fiveKmAway,
                                    style: TextStyle(
                                      color: ColorRes.white.withOpacity(0.80),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          AppRes.about,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontFamily: 'gilroy_bold',
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          AppRes.nataliyaBioText,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          AppRes.interest,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontFamily: 'gilroy_bold',
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 11),
                        interestButtons(),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: onChatWithTap,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: ColorRes.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                AppRes.chatWithNatalia,
                                style: TextStyle(
                                  color: ColorRes.red3,
                                  fontSize: 12,
                                  fontFamily: 'gilroy_bold',
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 11),
                        InkWell(
                          onTap: onShareWithTap,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: ColorRes.dimGrey7.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                AppRes.shareNataliaProfile,
                                style: TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 12,
                                  fontFamily: 'gilroy_bold',
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 27),
                        Center(
                          child: InkWell(
                            onTap: onReportTap,
                            child: Text(
                              AppRes.reportNatalia,
                              style: TextStyle(
                                color: ColorRes.white.withOpacity(0.50),
                                fontSize: 12,
                                fontFamily: 'gilroy_bold',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          hideInfoChip(),
        ],
      ),
    );
  }

  Widget hideInfoChip() {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onHideBtnTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(21, 10, 21, 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorRes.lightOrange1,
              ColorRes.darkOrange,
            ],
          ),
        ),
        child: Text(
          AppRes.hideInfo,
          style: TextStyle(
            color: ColorRes.white.withOpacity(0.80),
            fontSize: 11,
            fontFamily: "gilroy_bold",
            letterSpacing: 0.65,
          ),
        ),
      ),
    );
  }

  Widget interestButtons() {
    return Wrap(
      children: interestList
          .map<Widget>(
            (e) => Container(
              margin: const EdgeInsets.only(right: 8, bottom: 10),
              padding: const EdgeInsets.fromLTRB(20.6, 9.50, 20.6, 8.51),
              decoration: BoxDecoration(
                color: ColorRes.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                e,
                style: const TextStyle(
                  fontSize: 10,
                  color: ColorRes.white,
                  fontFamily: 'gilroy_bold',
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

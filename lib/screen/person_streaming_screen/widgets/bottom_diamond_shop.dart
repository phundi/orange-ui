import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class BottomDiamondShop extends StatelessWidget {
  final List<Map<String, dynamic>> diamondList;
  final Function(Map<String, dynamic> data) onDiamondPurchase;

  const BottomDiamondShop({
    Key? key,
    required this.diamondList,
    required this.onDiamondPurchase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          width: Get.width,
          height: 425,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: ColorRes.black.withOpacity(0.33),
          ),
          child: Column(
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: AppRes.diamond,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 17,
                        fontFamily: 'gilroy',
                      ),
                    ),
                    TextSpan(
                      text: " ${AppRes.shop}",
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 17,
                        fontFamily: 'gilroy_bold',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: diamondList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.fromLTRB(17, 13, 9, 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorRes.white.withOpacity(0.14),
                    ),
                    child: Row(
                      children: [
                        Image.asset(AssetRes.diamond, height: 24, width: 24),
                        const SizedBox(width: 7),
                        Text(
                          "${diamondList[index]['diamond']} ${AppRes.diamondsCamel}",
                          style: const TextStyle(
                            color: ColorRes.white,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            onDiamondPurchase(diamondList[index]);
                          },
                          child: Container(
                            width: 131,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorRes.lightOrange1,
                                  ColorRes.darkOrange,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "\$${diamondList[index]['price'].toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: ColorRes.white,
                                  fontSize: 15,
                                  fontFamily: 'gilroy_bold',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 23),
              SizedBox(
                width: Get.width / 1.7,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: [
                    TextSpan(
                      text: AppRes.bayContinuingThePurchaseEtc,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'gilroy',
                      ),
                    ),
                    TextSpan(
                      text: AppRes.terms,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ColorRes.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'gilroy',
                      ),
                    ),
                    TextSpan(
                      text: " ${AppRes.and} ",
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'gilroy',
                      ),
                    ),
                    TextSpan(
                      text: AppRes.privacyPolicy,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ColorRes.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'gilroy',
                      ),
                    ),
                    TextSpan(
                      text: " ${AppRes.automatically} ",
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'gilroy',
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class BottomPurchaseShirt extends StatelessWidget {
  final List<Map<String, dynamic>> diamondList;
  final VoidCallback onGemsSubmit;
  final VoidCallback onAddDiamonds;
  final Function(Map<String, dynamic> data) onDiamondTap;

  const BottomPurchaseShirt({
    Key? key,
    required this.diamondList,
    required this.onGemsSubmit,
    required this.onAddDiamonds,
    required this.onDiamondTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: Get.width,
          height: Get.width * 1.063,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: ColorRes.black.withOpacity(0.33),
          ),
          child: Column(
            children: [
              topButtons(),
              const SizedBox(height: 17),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: diamondList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.95,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      onDiamondTap(diamondList[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorRes.white.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            diamondList[index]['image'],
                            height: 45.5,
                            width: 52.45,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 2.5),
                          Text(
                            "${diamondList[index]['gems']} 💎",
                            style: const TextStyle(
                              color: ColorRes.white,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topButtons() {
    return Row(
      children: [
        InkWell(
          onTap: onAddDiamonds,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 35,
            width: 81,
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
            child: const Center(
              child: Text(
                "💎 200",
                style: TextStyle(
                  color: ColorRes.white,
                  fontSize: 13,
                  fontFamily: 'gilroy',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        InkWell(
          onTap: onAddDiamonds,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 35,
            width: 131,
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
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: AppRes.add,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 13,
                        fontFamily: 'gilroy',
                      ),
                    ),
                    TextSpan(
                      text: " ${AppRes.diamonds}",
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 13,
                        fontFamily: 'gilroy_bold',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

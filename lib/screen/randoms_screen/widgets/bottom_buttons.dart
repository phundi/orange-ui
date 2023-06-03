import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class BottomButtons extends StatelessWidget {
  final List<String> genderList;
  final String selectedGender;
  final Function(String value) onGenderSelect;
  final VoidCallback onMatchingStart;

  const BottomButtons({
    Key? key,
    required this.genderList,
    required this.selectedGender,
    required this.onGenderSelect,
    required this.onMatchingStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Text(
            AppRes.findSomeoneRandomly,
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorRes.darkGrey3),
          ),
          const Spacer(),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 28),
            decoration: BoxDecoration(
              color: ColorRes.grey22,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: selectedGender == AppRes.boys
                      ? Alignment.centerLeft
                      : selectedGender == AppRes.both
                          ? Alignment.center
                          : Alignment.centerRight,
                  child: Container(
                    width: (Get.width / genderList.length) -
                        14 -
                        (genderList.length * 5),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorRes.lightOrange1,
                            ColorRes.darkOrange,
                          ]),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () {
                          onGenderSelect(AppRes.boys);
                        },
                        child: SizedBox(
                          width: (Get.width / genderList.length) -
                              14 -
                              (genderList.length * 5),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: TextStyle(
                                color: selectedGender == AppRes.boys
                                    ? ColorRes.white
                                    : ColorRes.darkGrey3,
                                fontSize: 13,
                                fontFamily: 'gilroy_bold',
                              ),
                              child: const Text(AppRes.boys),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () {
                          onGenderSelect(AppRes.both);
                        },
                        child: SizedBox(
                          width: (Get.width / genderList.length) -
                              14 -
                              (genderList.length * 5),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: TextStyle(
                                color: selectedGender == AppRes.both
                                    ? ColorRes.white
                                    : ColorRes.darkGrey3,
                                fontSize: 13,
                                fontFamily: 'gilroy_bold',
                              ),
                              child: const Text(AppRes.both),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () {
                          onGenderSelect(AppRes.girls);
                        },
                        child: SizedBox(
                          width: (Get.width / genderList.length) -
                              14 -
                              (genderList.length * 5),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: TextStyle(
                                color: selectedGender == AppRes.girls
                                    ? ColorRes.white
                                    : ColorRes.darkGrey3,
                                fontSize: 13,
                                fontFamily: 'gilroy_bold',
                              ),
                              child: const Text(AppRes.girls),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height / 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onMatchingStart,
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorRes.orange3.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    AppRes.startMatching,
                    style: TextStyle(
                      color: ColorRes.orange3,
                      fontFamily: 'gilroy_bold',
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height / 60),
        ],
      ),
    );
  }
}

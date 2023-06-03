import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class CenterAreaLiveStream extends StatelessWidget {
  final TextEditingController aboutController;
  final TextEditingController languageController;
  final TextEditingController videoController;
  final TextEditingController link1Controller;
  final TextEditingController link2Controller;
  final VoidCallback onSubmitTap;
  final VoidCallback onAddBtnTap;
  final VoidCallback onRemoveBtnTap;
  final Function(String? value) onVideoControllerChange;

  const CenterAreaLiveStream({
    Key? key,
    required this.aboutController,
    required this.languageController,
    required this.videoController,
    required this.link1Controller,
    required this.link2Controller,
    required this.onSubmitTap,
    required this.onAddBtnTap,
    required this.onRemoveBtnTap,
    required this.onVideoControllerChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 15, bottom: 9),
                child: Text(
                  AppRes.something,
                  style: TextStyle(
                    fontFamily: 'gilroy_extra_bold',
                    fontSize: 15,
                    color: ColorRes.darkGrey3,
                  ),
                ),
              ),
              Container(
                  height: 103,
                  width: Get.width - 14,
                  padding: const EdgeInsets.only(left: 12, top: 12),
                  decoration: BoxDecoration(
                    color: ColorRes.lightGrey2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    controller: aboutController,
                    decoration: const InputDecoration(
                      hintText: AppRes.shortIntro,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: ColorRes.dimGrey3, fontSize: 14),
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 10, bottom: 6),
                child: Text(
                  AppRes.languages,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'gilroy_extra_bold',
                    color: ColorRes.darkGrey3,
                  ),
                ),
              ),
              Container(
                height: 71,
                width: Get.width - 14,
                padding: const EdgeInsets.only(left: 12, top: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorRes.lightGrey2),
                child: TextField(
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  controller: languageController,
                  decoration: const InputDecoration(
                    hintText: AppRes.languagesDetail,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: ColorRes.dimGrey3,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 12, bottom: 6),
                child: Text(
                  AppRes.intro,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'gilroy_extra_bold',
                      color: ColorRes.darkGrey3),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 67,
                    width: Get.width - 14,
                    decoration: BoxDecoration(
                        color: ColorRes.lightGrey2,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      controller: videoController,
                      onChanged: onVideoControllerChange,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10, left: 12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  videoController.text != ''
                      ? const SizedBox()
                      : const Text(
                          AppRes.attach,
                          style: TextStyle(
                            color: ColorRes.dimGrey3,
                            fontSize: 14,
                          ),
                        ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 17, bottom: 6),
                child: Text(
                  AppRes.social,
                  style: TextStyle(
                    color: ColorRes.darkGrey3,
                    fontSize: 15,
                    fontFamily: 'gilroy_extra_bold',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, bottom: 12),
                child: Text(
                  AppRes.socialdata,
                  style: TextStyle(
                    color: ColorRes.grey25,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                height: 43,
                width: Get.width,
                padding: const EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.lightGrey2,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: link1Controller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10, left: 12),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: onAddBtnTap,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorRes.tometo,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: ColorRes.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 43,
                width: Get.width,
                padding: const EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.lightGrey2,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: link2Controller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10, left: 12),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onRemoveBtnTap,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorRes.lighttometo,
                        ),
                        child: const Center(
                          child: Text(
                            '-',
                            style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 33),
              InkWell(
                onTap: onSubmitTap,
                child: Container(
                  height: 41,
                  width: Get.width,
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
                      AppRes.submit,
                      style: TextStyle(
                        color: ColorRes.white,
                        fontSize: 12,
                        fontFamily: 'gilroy_semibold',
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }
}

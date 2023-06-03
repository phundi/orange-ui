import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/starting_profile_screen/widet/text_field_area/text_field_controller.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class TopCardArea extends StatelessWidget {
  final String fullName;

  TopCardArea({Key? key, required this.fullName}) : super(key: key);

  final TextFieldController controller = Get.put(TextFieldController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            //height: 100,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage(AssetRes.blurBG1),
                fit: BoxFit.cover,
              ),
            ),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: fullName,
                            style: const TextStyle(
                              color: ColorRes.white,
                              fontSize: 18,
                              fontFamily: "gilroy_bold",
                            ),
                          ),
                          TextSpan(
                            text: controller.age.value,
                            style: const TextStyle(
                              color: ColorRes.white,
                              fontSize: 18,
                              fontFamily: "gilroy",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Image.asset(AssetRes.locationPin,
                            height: 13, width: 13),
                        const SizedBox(width: 5),
                        Text(
                          controller.address.value,
                          style: const TextStyle(
                            color: ColorRes.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      controller.bio.value,
                      style: const TextStyle(
                        color: ColorRes.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

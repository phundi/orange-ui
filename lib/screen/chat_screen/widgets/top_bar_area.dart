import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class TopBarArea extends StatelessWidget {
  final Map<String, dynamic> user;
  final VoidCallback onBack;
  final VoidCallback onVideoCallingTap;
  final VoidCallback onMoreBtnTap;

  const TopBarArea({
    Key? key,
    required this.user,
    required this.onBack,
    required this.onVideoCallingTap,
    required this.onMoreBtnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(21, 18, 23, 18),
            child: Row(
              children: [
                InkWell(
                  onTap: onBack,
                  child: Image.asset(
                    AssetRes.backArrow,
                    height: 20,
                    width: 10,
                  ),
                ),
                const SizedBox(width: 19),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    user['avatar'],
                    height: 37,
                    width: 37,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user['name'],
                          style: const TextStyle(
                            color: ColorRes.darkGrey4,
                            fontSize: 16,
                            fontFamily: 'gilroy_bold',
                          ),
                        ),
                        Text(
                          " ${user['age']}",
                          style: const TextStyle(
                            color: ColorRes.darkGrey4,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(AssetRes.tickMark, height: 15, width: 15),
                      ],
                    ),
                    Text(
                      user['address'],
                      style: const TextStyle(
                        color: ColorRes.grey6,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: onVideoCallingTap,
                  child: Image.asset(
                    AssetRes.videoCalling,
                    height: 11.85,
                    width: 22,
                  ),
                ),
                const SizedBox(width: 14),
                InkWell(
                  onTap: onMoreBtnTap,
                  child: Image.asset(
                    AssetRes.moreHorizontal,
                    height: 27,
                    width: 27,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            width: Get.width,
            margin: const EdgeInsets.only(right: 10, left: 10, bottom: 5.5),
            color: ColorRes.grey9,
          ),
        ],
      ),
    );
  }
}

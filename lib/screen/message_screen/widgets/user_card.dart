import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String age;
  final String msg;
  final String time;
  final String image;
  final bool newMsg;
  final bool sendByYou;
  final bool tickMark;

  const UserCard({
    Key? key,
    required this.name,
    required this.age,
    required this.msg,
    required this.time,
    required this.image,
    required this.newMsg,
    required this.sendByYou,
    required this.tickMark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding:
              const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 11),
          height: 74,
          width: Get.width,
          decoration: BoxDecoration(
            color: ColorRes.skyBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  image,
                  height: 53,
                  width: 53,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                height: 74,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              color: ColorRes.veryDarkGrey3,
                              fontFamily: 'gilroy_bold',
                              fontSize: 16),
                        ),
                        Text(
                          age,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 4),
                        tickMark
                            ? Image.asset(
                                AssetRes.tickMark,
                                height: 17.5,
                                width: 18.33,
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: Get.width - 120,
                      child: Text(
                        msg,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: ColorRes.grey3,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 12, color: ColorRes.grey4),
              ),
              const SizedBox(height: 6),
              Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: newMsg
                      ? const LinearGradient(
                          colors: [
                            ColorRes.orange2,
                            ColorRes.red2,
                          ],
                        )
                      : null,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

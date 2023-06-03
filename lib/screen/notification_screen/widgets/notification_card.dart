import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class NotificationCard extends StatelessWidget {
  final String name;
  final String image;
  final String age;
  final String msg;
  final String time;

  const NotificationCard({
    Key? key,
    required this.name,
    required this.image,
    required this.age,
    required this.msg,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 19, bottom: 18),
          child: Row(
            children: [
              image == "orange"
                  ? Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorRes.lightOrange1,
                            ColorRes.darkOrange,
                          ],
                        ),
                      ),
                    )
                  : Image.asset(
                      image,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(width: 13),
              SizedBox(
                width: Get.width - 94,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontFamily: 'gilroy_bold',
                            fontSize: 15,
                            color: ColorRes.darkGrey4,
                          ),
                        ),
                        image == "orange"
                            ? const SizedBox()
                            : Text(
                                ' $age',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: ColorRes.darkGrey4,
                                ),
                              ),
                        const SizedBox(
                          width: 4,
                        ),
                        image == "orange"
                            ? const SizedBox()
                            : Image.asset(
                                AssetRes.tickMark,
                                height: 14.87,
                                width: 15.58,
                              )
                      ],
                    ),
                    Text(
                      msg,
                      style: const TextStyle(
                        fontSize: 13,
                        color: ColorRes.grey6,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 19,
          child: Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: ColorRes.grey7,
            ),
          ),
        ),
      ],
    );
  }
}

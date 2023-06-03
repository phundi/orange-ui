import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/color_res.dart';

class ChatArea extends StatelessWidget {
  final List<Map<String, dynamic>> chatData;
  final Function(Map<String, dynamic> imageData) onImageTap;

  const ChatArea({
    Key? key,
    required this.chatData,
    required this.onImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: chatData.length,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: chatData[index]['type'] == 'alert'
                ? alertView(chatData[index])
                : chatData[index]['sender'] == 'You'
                    ? yourMsg(chatData[index])
                    : otherUserMsg(chatData[index]),
          );
        },
      ),
    );
  }

  Widget yourMsg(Map<String, dynamic> data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          data['time'],
          style: const TextStyle(
            color: ColorRes.grey11,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorRes.lightOrange1,
                ColorRes.darkOrange,
              ],
            ),
          ),
          child: data['type'] == 'image'
              ? imageView(data)
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Get.width / 1.4,
                    minWidth: 130,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(11, 13, 8, 11),
                    child: Text(
                      data['msg'],
                      style: const TextStyle(color: ColorRes.white),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget otherUserMsg(Map<String, dynamic> data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        data['type'] == 'image'
            ? imageView(data)
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorRes.grey12,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Get.width / 1.4,
                    minWidth: 200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 13, 12, 11),
                    child: Text(
                      data['msg'],
                      style: const TextStyle(color: ColorRes.darkGrey6),
                    ),
                  ),
                ),
              ),
        const SizedBox(width: 10),
        Text(
          data['time'],
          style: const TextStyle(
            color: ColorRes.grey11,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget imageView(Map<String, dynamic> data) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        onImageTap(data);
      },
      child: Container(
        decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 3,
                color: ColorRes.grey.withOpacity(0.30),
              ),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Image.asset(
              data['msg'],
              height: 171,
              width: 171,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget alertView(Map<String, dynamic> data) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: ColorRes.grey13,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          data['msg'],
          style: const TextStyle(color: ColorRes.grey14, fontSize: 11),
        ),
      ),
    );
  }
}

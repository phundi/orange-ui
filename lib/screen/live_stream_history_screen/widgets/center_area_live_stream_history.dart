import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class CenterAreaLiveStream extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;

  const CenterAreaLiveStream({Key? key, required this.dataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: dataList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return customContainer(
            dataList[index]['time'],
            dataList[index]['date'],
            dataList[index]['duration'],
            dataList[index]['diamonds'],
          );
        },
      ),
    );
  }

  Widget customContainer(
      String time, String date, String streamed, String collected) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.only(top: 12, left: 13, bottom: 12, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorRes.grey26,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                AppRes.time,
                style: TextStyle(
                  color: ColorRes.grey28,
                  fontFamily: 'gilroy_semibold',
                ),
              ),
              Expanded(
                child: Text(
                  " $time",
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorRes.grey27,
                  ),
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                  color: ColorRes.grey27,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              const Text(
                AppRes.streamed,
                style: TextStyle(
                  color: ColorRes.grey28,
                  fontFamily: 'gilroy_semibold',
                ),
              ),
              Text(
                " $streamed",
                style: const TextStyle(
                  fontFamily: 'gilroy',
                  fontSize: 14,
                  color: ColorRes.grey27,
                ),
              )
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              const Text(
                AppRes.diamound,
                style: TextStyle(
                  color: ColorRes.grey28,
                  fontFamily: 'gilroy_semibold',
                ),
              ),
              Text(
                " $collected",
                style: const TextStyle(
                  fontFamily: 'gilroy',
                  fontSize: 14,
                  color: ColorRes.grey27,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

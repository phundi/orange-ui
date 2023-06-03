import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class CenterAreaRedeemScreen extends StatelessWidget {
  const CenterAreaRedeemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 1),
        customContainer(
          ColorRes.lightpink.withOpacity(0.20),
          'Processing',
          ColorRes.lightorange,
          '5 Sep 2021',
          ' 50236',
          '',
        ),
        customContainer(
          ColorRes.lightgreen.withOpacity(0.22),
          'Completed',
          ColorRes.darkgreen,
          '1 Sep 2021',
          ' 50236',
          ' \$250',
        ),
        customContainer(
          ColorRes.lightgreen.withOpacity(0.22),
          'Completed',
          ColorRes.darkgreen,
          '25 Oct 2021',
          ' 60236',
          ' \$320',
        ),
        customContainer(
          ColorRes.lightgreen.withOpacity(0.22),
          'Completed',
          ColorRes.darkgreen,
          '19 Oct 2021',
          ' 60236',
          ' \$320',
        ),
      ],
    );
  }

  Widget customContainer(
    Color color,
    String text,
    Color textColor,
    String date,
    String data,
    String amount,
  ) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(left: 7, right: 7, bottom: 5),
      padding: const EdgeInsets.only(top: 10, left: 11, bottom: 11, right: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorRes.grey26,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                AppRes.data,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'gilroy_semibold',
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 5, 13, 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: color,
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontFamily: 'gilroy_semibold',
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                date,
                style: const TextStyle(
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
                AppRes.diamond1,
                style: TextStyle(
                    color: ColorRes.grey27, fontSize: 14, fontFamily: 'gilroy'),
              ),
              Text(
                data,
                style: const TextStyle(
                  color: ColorRes.grey28,
                  fontSize: 14,
                  fontFamily: 'gilroy_semibold',
                ),
              )
            ],
          ),
          const SizedBox(height: 6),
          amount == ''
              ? const SizedBox()
              : Row(
                  children: [
                    const Text(
                      AppRes.amount,
                      style: TextStyle(color: ColorRes.grey27, fontSize: 14),
                    ),
                    Text(
                      amount,
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorRes.grey28,
                        fontFamily: 'gilroy_semibold',
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}

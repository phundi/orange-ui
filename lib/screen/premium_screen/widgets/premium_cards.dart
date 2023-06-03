import 'package:flutter/material.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class PremiumCards extends StatelessWidget {
  final int selectedOffer;
  final Function(int index) onOfferSelect;

  const PremiumCards({
    Key? key,
    required this.selectedOffer,
    required this.onOfferSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 11),
        Expanded(
          child: offerCard(
            0,
            AppRes.bestValue,
            12,
            AppRes.months,
            "\$ 4.1/mth",
            "\$ 49.00",
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: offerCard(
            1,
            AppRes.popular,
            6,
            AppRes.months,
            "\$ 5.0/mth",
            "\$ 30.00",
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: offerCard(
            2,
            AppRes.tryIt,
            1,
            AppRes.month,
            '',
            "\$ 8.00",
          ),
        ),
        const SizedBox(width: 11),
      ],
    );
  }

  Widget offerCard(
    int index,
    String title,
    int time,
    String monthText,
    String subTitle,
    String amount,
  ) {
    bool select = selectedOffer == index;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        onOfferSelect(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: select ? ColorRes.white : ColorRes.white.withOpacity(0.20),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: select ? ColorRes.black : ColorRes.white,
                  fontSize: 13,
                  fontFamily: 'gilroy_bold',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                time.toString(),
                style: TextStyle(
                  color: select ? ColorRes.veryDarkGrey4 : ColorRes.white,
                  fontSize: 42,
                ),
              ),
              Text(
                monthText,
                style: TextStyle(
                  color: select ? ColorRes.veryDarkGrey4 : ColorRes.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subTitle,
                style: TextStyle(
                  color: select ? ColorRes.grey8 : ColorRes.white,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                amount,
                style: TextStyle(
                  color: select ? ColorRes.darkGrey5 : ColorRes.white,
                  fontSize: 20,
                  fontFamily: 'gilroy_bold',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

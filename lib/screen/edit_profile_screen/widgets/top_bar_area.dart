import 'package:flutter/material.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class TopBarArea extends StatelessWidget {
  final VoidCallback onBackBtnTap;

  const TopBarArea({Key? key, required this.onBackBtnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 40, 23, 18),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                AppRes.edit,
                style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                ),
              ),
              SizedBox(width: 3),
              Text(
                AppRes.profileCap,
                style: TextStyle(
                  fontSize: 17,
                  color: ColorRes.black,
                  fontFamily: 'gilroy_bold',
                ),
              ),
            ],
          ),
          InkWell(
            onTap: onBackBtnTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 37,
              width: 37,
              padding: const EdgeInsets.only(right: 3),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetRes.backButton),
                ),
              ),
              child: Center(
                child: Image.asset(
                  AssetRes.backArrow,
                  height: 14,
                  width: 7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

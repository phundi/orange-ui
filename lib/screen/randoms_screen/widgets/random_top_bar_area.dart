import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class RandomTopBarArea extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchBtnTap;

  const RandomTopBarArea({
    Key? key,
    required this.onNotificationTap,
    required this.onSearchBtnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onNotificationTap,
                child: Container(
                  height: 37,
                  width: 37,
                  decoration: BoxDecoration(
                      color: ColorRes.orange3.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      AssetRes.bell,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: onSearchBtnTap,
                child: Container(
                  height: 37,
                  width: 37,
                  decoration: BoxDecoration(
                      color: ColorRes.orange3.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      AssetRes.search,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Image.asset(
            AssetRes.themeLabel,
            height: 28,
            width: 94,
          ),
        ],
      ),
    );
  }
}

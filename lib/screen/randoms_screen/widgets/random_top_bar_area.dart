import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';

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
                child: Image.asset(
                  AssetRes.bell,
                  height: 37,
                  width: 37,
                ),
              ),
              InkWell(
                onTap: onSearchBtnTap,
                child: Image.asset(
                  AssetRes.search,
                  height: 37,
                  width: 37,
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

import 'package:flutter/material.dart';
import 'package:orange_ui/utils/asset_res.dart';

class MessageTopArea extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;

  const MessageTopArea({
    Key? key,
    required this.onNotificationTap,
    required this.onSearchTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
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
                onTap: onSearchTap,
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

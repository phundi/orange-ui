import 'package:flutter/material.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class ProfileTopArea extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;

  const ProfileTopArea({
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
              Visibility(
                visible: PrefService.settingData?.appdata?.isDating == 0
                    ? false
                    : true,
                child: InkWell(
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
              ),
              InkWell(
                onTap: onSearchTap,
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

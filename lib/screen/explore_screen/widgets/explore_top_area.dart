import 'package:flutter/material.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class ExploreTopArea extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onTitleTap;
  final VoidCallback onSearchTap;

  const ExploreTopArea({
    Key? key,
    required this.onNotificationTap,
    required this.onSearchTap,
    required this.onTitleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                  borderRadius: BorderRadius.circular(20),
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
                borderRadius: BorderRadius.circular(20),
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
          InkWell(
            onTap: onTitleTap,
            child: Image.asset(
              AssetRes.themeLabel,
              height: 28,
              width: 94,
            ),
          ),
        ],
      ),
    );
  }
}

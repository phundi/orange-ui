import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class OptionsCenterArea extends StatelessWidget {
  final bool notificationEnable;
  final bool showMeOnMap;
  final bool goAnnonymous;

  final VoidCallback onGoPremiumTap;
  final VoidCallback onLiveStreamTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onShowMeOnMapTap;
  final VoidCallback onAnnonymousTap;

  const OptionsCenterArea({
    Key? key,
    required this.notificationEnable,
    required this.showMeOnMap,
    required this.goAnnonymous,
    required this.onGoPremiumTap,
    required this.onLiveStreamTap,
    required this.onNotificationTap,
    required this.onShowMeOnMapTap,
    required this.onAnnonymousTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        InkWell(
          onTap: onGoPremiumTap,
          child: Container(
            height: 49,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              //color: ColorRes.lightOrange2,
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorRes.lightOrange1,
                  ColorRes.darkOrange,
                ],
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  AssetRes.premiumCrown,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 21),
                const Text(
                  AppRes.go,
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 15,
                    fontFamily: 'gilroy',
                  ),
                ),
                const Text(
                  " ${AppRes.premium}",
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'gilroy_extra_bold',
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 9),
        InkWell(
          onTap: onLiveStreamTap,
          child: Container(
            height: 49,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorRes.grey12),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 12, bottom: 12),
                  child: Image.asset(
                    AssetRes.sun,
                    height: 25,
                    width: 25,
                  ),
                ),
                const SizedBox(width: 21),
                const Text(
                  AppRes.livestream,
                  style: TextStyle(
                    color: ColorRes.blueGrey,
                    fontSize: 15,
                    fontFamily: 'gilroy_semibold',
                  ),
                )
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 17, bottom: 9),
          child: Text(
            AppRes.privacy,
            style: TextStyle(
              color: ColorRes.grey23,
              fontSize: 14,
              fontFamily: 'gilroy_bold',
              letterSpacing: 0.8,
            ),
          ),
        ),
        permissionTile(
          0,
          AppRes.pushNotification,
          AppRes.notificationData,
          notificationEnable,
          onNotificationTap,
        ),
        const SizedBox(height: 9),
        permissionTile(
          1,
          AppRes.switchMap,
          AppRes.switchMapData,
          showMeOnMap,
          onShowMeOnMapTap,
        ),
        const SizedBox(height: 10),
        permissionTile(
          2,
          AppRes.annonymous,
          AppRes.annonymousData,
          goAnnonymous,
          onAnnonymousTap,
        ),
      ],
    );
  }

  Widget permissionTile(int index, String title, String subTitle, bool enable,
      VoidCallback onTap) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.fromLTRB(
          14, index == 0 ? 21 : 14, 8, index == 0 ? 21 : 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorRes.grey12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: ColorRes.grey24,
                  fontFamily: 'gilroy_semibold',
                ),
              ),
              const SizedBox(height: 3),
              SizedBox(
                width: Get.width - 90,
                child: Text(
                  subTitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorRes.grey25,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: Container(
              height: 25,
              width: 36,
              padding: const EdgeInsets.symmetric(horizontal: 3.5),
              alignment: enable ? Alignment.centerRight : Alignment.centerLeft,
              decoration: BoxDecoration(
                color: ColorRes.grey,
                borderRadius: BorderRadius.circular(30),
                gradient: enable
                    ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorRes.lightOrange1,
                          ColorRes.darkOrange,
                        ],
                      )
                    : null,
              ),
              child: Container(
                height: 19,
                width: 19,
                decoration: const BoxDecoration(
                  color: ColorRes.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

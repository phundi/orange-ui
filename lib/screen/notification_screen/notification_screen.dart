import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/notification_screen/widgets/notification_card.dart';
import 'package:orange_ui/screen/notification_screen/widgets/top_area_notifiction.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

import 'notification_screen_view_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => NotificationScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopArea(notification: model.notification, onBack: model.onBack),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                height: 1,
                width: Get.width,
                color: ColorRes.grey5,
              ),
              const SizedBox(height: 11),
              Container(
                height: 50,
                width: 254,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.grey32,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => model.onTabChange(0),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 40,
                        width: 132,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: model.tabIndex == 0
                              ? ColorRes.darkGrey10
                              : ColorRes.grey32,
                        ),
                        child: Center(
                          child: Text(
                            AppRes.personal,
                            style: TextStyle(
                              color: model.tabIndex == 0
                                  ? ColorRes.white
                                  : ColorRes.darkGrey10,
                              fontFamily: 'gilroy',
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => model.onTabChange(1),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 40,
                        width: 112,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: model.tabIndex == 1
                              ? ColorRes.darkGrey10
                              : ColorRes.grey32,
                        ),
                        child: Center(
                          child: Text(
                            AppRes.platform,
                            style: TextStyle(
                              color: model.tabIndex == 1
                                  ? ColorRes.white
                                  : ColorRes.darkGrey10,
                              fontFamily: 'gilroy',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 15),
                  itemCount: model.notificationList.length,
                  itemBuilder: (context, index) {
                    if (model.notificationList[index]['type'] == 'personal' &&
                        model.tabIndex == 1) {
                      return const SizedBox();
                    }
                    if (model.notificationList[index]['type'] == 'platform' &&
                        model.tabIndex == 0) {
                      return const SizedBox();
                    }
                    return NotificationCard(
                      image: model.notificationList[index]['image'],
                      age: model.notificationList[index]['age'].toString(),
                      msg: model.notificationList[index]['msg'],
                      name: model.notificationList[index]['name'],
                      time: model.notificationList[index]['time'],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

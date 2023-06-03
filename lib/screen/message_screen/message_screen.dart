import 'package:flutter/material.dart';
import 'package:orange_ui/screen/message_screen/message_screen_view_model.dart';
import 'package:orange_ui/screen/message_screen/widgets/user_card.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

import 'widgets/message_top_area.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => MessageScreenViewModel(),
      builder: (context, model, child) {
        return Container(
          color: ColorRes.white,
          child: Column(
            children: [
              MessageTopArea(
                onNotificationTap: model.onNotificationTap,
                onSearchTap: model.onSearchTap,
              ),
              const SizedBox(height: 3),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  itemCount: model.userList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: model.onUserTap,
                      child: UserCard(
                        name: model.userList[index]['name'],
                        age: model.userList[index]['age'].toString(),
                        msg: model.userList[index]['msg'],
                        time: model.userList[index]['time'],
                        image: model.userList[index]['image'],
                        newMsg: model.userList[index]['newMsg'],
                        sendByYou: model.userList[index]['sendByYou'],
                        tickMark: model.userList[index]['tickMark'],
                      ),
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

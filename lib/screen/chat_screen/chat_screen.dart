import 'package:flutter/material.dart';
import 'package:orange_ui/screen/chat_screen/chat_screen_view_model.dart';
import 'package:orange_ui/screen/chat_screen/widgets/bottom_input_bar.dart';
import 'package:orange_ui/screen/chat_screen/widgets/chat_area.dart';
import 'package:orange_ui/screen/chat_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => ChatScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              TopBarArea(
                user: model.user,
                onBack: model.onBackBtnTap,
                onMoreBtnTap: model.onMoreBtnTap,
                onVideoCallingTap: model.onVideoCallingTap,
              ),
              ChatArea(
                  chatData: model.chatData.reversed.toList(),
                  onImageTap: model.onImageTap),
              BottomInputBar(
                msgController: model.controller,
                onShareBtnTap: model.onShareBtnTap,
                onAddBtnTap: model.onAddBtnTap,
                onCameraTap: model.onCameraTap,
              ),
              const SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }
}

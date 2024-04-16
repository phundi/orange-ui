import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/feed_screen/feed_screen_view_model.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_post_card.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class HashtagScreen extends StatelessWidget {
  final String hashtagName;

  const HashtagScreen({Key? key, required this.hashtagName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: ColorRes.veryDarkGrey4,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        hashtagName,
                        style: const TextStyle(fontFamily: FontRes.bold, fontSize: 18, color: ColorRes.orange2),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => FeedPostCard(
                onCommentBtnClick: () {},
                model: FeedScreenViewModel(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

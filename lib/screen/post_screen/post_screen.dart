import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/feed_screen/widget/feed_post_card.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SafeArea(
                bottom: false,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back, color: ColorRes.veryDarkGrey4)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: SmoothBorderRadius(cornerRadius: 7, cornerSmoothing: 1),
                              child: Image.asset(
                                AssetRes.icImage2,
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(width: 10),
                          const Flexible(
                            child: Text(
                              '@jessi_robinson',
                              style: TextStyle(fontFamily: FontRes.bold, fontSize: 16, color: ColorRes.dimGrey3),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Text(' 24 ',
                              style: TextStyle(fontFamily: FontRes.regular, color: ColorRes.dimGrey3, fontSize: 16)),
                          Image.asset(
                            AssetRes.icBlueTick,
                            width: 18,
                          )
                        ],
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
              ),
            ))
          ],
        ));
  }
}

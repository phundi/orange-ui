import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class CommentListArea extends StatelessWidget {
  final List<Map<String, dynamic>> commentList;
  final BuildContext pageContext;

  const CommentListArea({
    Key? key,
    required this.commentList,
    required this.pageContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double tempSize = MediaQuery.of(pageContext).viewInsets.bottom == 0
        ? 0
        : MediaQuery.of(pageContext).viewInsets.bottom;
    return SizedBox(
      height: (tempSize == 0)
          ? (Get.height - 270) / 2
          : (Get.height - 270) - tempSize - 50,
      width: Get.width,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorRes.red,
              Colors.transparent,
              Colors.transparent,
            ],
            stops: [0.0, 0.3, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstOut,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: commentList.length,
          reverse: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      commentList[index]['image'],
                      fit: BoxFit.cover,
                      height: 32,
                      width: 32,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: Get.width / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commentList[index]['name'],
                          style: TextStyle(
                            color: ColorRes.white.withOpacity(0.65),
                            fontSize: 12,
                          ),
                        ),
                        commentList[index]['type'] == "text"
                            ? Text(
                                commentList[index]['comment'],
                                style: TextStyle(
                                  color: ColorRes.white.withOpacity(0.90),
                                  fontSize: 13,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                                  child: Container(
                                    height: 54,
                                    width: 54,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ColorRes.black.withOpacity(0.33),
                                    ),
                                    child: Image.asset(
                                      AssetRes.heart,
                                      width: 40,
                                      height: 35,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

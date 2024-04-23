import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/common_ui.dart';
import 'package:orange_ui/model/social/post/fetch_comment.dart';
import 'package:orange_ui/screen/comment_sheet/comment_sheet_view_model.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class CommentCard extends StatelessWidget {
  final CommentData commentData;
  final CommentSheetViewModel model;
  const CommentCard({Key? key, required this.commentData, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        SmoothBorderRadius(cornerRadius: 7, cornerSmoothing: 1),
                    child: CachedNetworkImage(
                      imageUrl: CommonFun.getProfileImage(
                          images: commentData.user?.images),
                      cacheKey: CommonFun.getProfileImage(
                          images: commentData.user?.images),
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return CommonUI.profileImagePlaceHolder(
                            name: commentData.user?.fullname,
                            heightWidth: 30,
                            borderRadius: 7);
                      },
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            commentData.user?.fullname ?? '',
                            style: const TextStyle(
                                color: ColorRes.veryDarkGrey4,
                                fontFamily: FontRes.semiBold,
                                fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: ColorRes.dimGrey6,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          '  ${CommonFun.timeAgo(DateTime.parse(commentData.createdAt ?? ''))}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: ColorRes.dimGrey3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  commentData.user?.id == PrefService.userId
                      ? InkWell(
                          onTap: () =>
                              model.deleteComment(commentData.id ?? -1),
                          child: Image.asset(AssetRes.icBin,
                              height: 22, width: 22),
                        )
                      : const SizedBox()
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
                child: DetectableText(
                  text: commentData.description ?? '',
                  detectionRegExp: RegExp(r"\B#\w\w+"),
                  detectedStyle: const TextStyle(
                      fontFamily: FontRes.bold,
                      color: ColorRes.orange2,
                      fontSize: 14),
                  basicStyle: const TextStyle(
                      color: ColorRes.dimGrey3,
                      fontSize: 14,
                      fontFamily: FontRes.medium),
                ),
              )
            ],
          ),
        ),
        const Divider(
          color: ColorRes.greyShade200,
          thickness: 1,
          height: 1,
        )
      ],
    );
  }
}

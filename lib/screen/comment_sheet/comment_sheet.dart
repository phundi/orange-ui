import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/social/feed.dart';
import 'package:orange_ui/model/social/post/fetch_comment.dart';
import 'package:orange_ui/screen/comment_sheet/comment_sheet_view_model.dart';
import 'package:orange_ui/screen/comment_sheet/widget/bottom_comment_field.dart';
import 'package:orange_ui/screen/comment_sheet/widget/comment_card.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:stacked/stacked.dart';

class CommentSheet extends StatelessWidget {
  final Posts? post;

  const CommentSheet({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentSheetViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      viewModelBuilder: () => CommentSheetViewModel(post),
      builder: (context, model, child) {
        return Container(
          margin: EdgeInsets.only(top: AppBar().preferredSize.height * 1.3),
          decoration: const ShapeDecoration(
            color: ColorRes.white,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius.vertical(top: SmoothRadius(cornerRadius: 40, cornerSmoothing: 0)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: Text(
                    S.of(context).comments,
                    style: const TextStyle(color: ColorRes.veryDarkGrey4, fontFamily: FontRes.bold, fontSize: 18),
                  ),
                ),
              ),
              const Divider(color: ColorRes.greyShade200, thickness: 1),
              Expanded(
                child: model.comments.isEmpty
                    ? Center(
                        child: Text(
                        '${S.of(context).noComment}!!',
                        style: const TextStyle(fontFamily: FontRes.medium, color: ColorRes.grey, fontSize: 16),
                      ))
                    : ListView.builder(
                        controller: model.scrollController,
                        itemCount: model.comments.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          CommentData commentData = model.comments[index];
                          return CommentCard(commentData: commentData, model: model);
                        }),
              ),
              BottomCommentField(model: model)
            ],
          ),
        );
      },
    );
  }
}

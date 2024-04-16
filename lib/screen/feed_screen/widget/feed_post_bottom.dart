import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/model/social/feed.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:orange_ui/utils/urls.dart';

class BottomAreaPost extends StatelessWidget {
  final VoidCallback onCommentBtnClick;
  final Posts? posts;

  const BottomAreaPost({
    Key? key,
    required this.onCommentBtnClick,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
      child: Row(
        children: [
          InkWell(
            onTap: onCommentBtnClick,
            child: Row(
              children: [
                Image.asset(AssetRes.icComment, height: 22, width: 22),
                Text('  ${NumberFormat.compact().format(posts?.commentsCount ?? 0)}',
                    style: const TextStyle(
                        color: ColorRes.veryDarkGrey4, fontFamily: FontRes.medium, letterSpacing: 0.5, fontSize: 15)),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(height: 20, width: 1, color: ColorRes.lightGrey),
          const SizedBox(width: 15),
          LikeButton(posts: posts),
          const SizedBox(width: 5),
          Container(height: 20, width: 1, color: ColorRes.lightGrey),
          const SizedBox(width: 10),
          Image.asset(AssetRes.icPostShare, height: 22, width: 22),
          const Spacer(),
          Text(CommonFun.timeAgo(DateTime.parse(posts?.createdAt ?? '')),
              style: const TextStyle(fontFamily: FontRes.medium, fontSize: 12, color: ColorRes.dimGrey3))
        ],
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  final Posts? posts;

  const LikeButton({Key? key, required this.posts}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {
  bool isLike = false;
  late final AnimationController _controller =
      AnimationController(duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  void initState() {
    fetchLikePost();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        if (isLike) {
          widget.posts?.setLikesCount(-1);
          ApiProvider().callPost(completion: (response) {}, url: Urls.aDislikePost, param: {
            Urls.aUserId: PrefService.userId,
            Urls.aPostId: widget.posts?.id,
          });
        } else {
          widget.posts?.setLikesCount(1);
          ApiProvider().callPost(completion: (response) {}, url: Urls.aLikePost, param: {
            Urls.aUserId: PrefService.userId,
            Urls.aPostId: widget.posts?.id,
          });
        }
        isLike = !isLike;
        setState(() {});
        _controller.reverse().then((value) => _controller.forward());
      },
      child: Row(
        children: [
          ScaleTransition(
              scale: Tween(begin: 0.7, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
              child: Image.asset(isLike ? AssetRes.icFillFav : AssetRes.icFav, height: 22, width: 22)),
          Text('  ${NumberFormat.compact().format(widget.posts?.likesCount ?? 0)}  ',
              style: const TextStyle(
                  color: ColorRes.veryDarkGrey4, fontFamily: FontRes.medium, letterSpacing: 0.5, fontSize: 15)),
        ],
      ),
    );
  }

  void fetchLikePost() {
    isLike = widget.posts?.isLike == 1;
    setState(() {});
  }
}

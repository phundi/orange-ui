import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/model/social/feed.dart';
import 'package:orange_ui/model/social/post/delete_post.dart';
import 'package:orange_ui/screen/comment_sheet/comment_sheet.dart';
import 'package:orange_ui/screen/create_post_screen/create_post_screen.dart';
import 'package:orange_ui/screen/user_report_screen/report_sheet.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:stacked/stacked.dart';

enum MoreBtnValue { report, delete, share }

class FeedScreenViewModel extends BaseViewModel {
  List<Posts> postList = [];
  List<UsersStories> stories = [];
  bool isLoading = true;
  ScrollController scrollController = ScrollController();
  MoreBtnValue moreBtnValue = MoreBtnValue.share;

  void init() {
    fetchFeedData();
  }

  void fetchFeedData() {
    isLoading = true;
    ApiProvider().callPost(
        completion: (response) {
          isLoading = false;
          Feed feed = Feed.fromJson(response);
          postList = feed.data?.posts ?? [];
          stories = feed.data?.usersStories ?? [];
          notifyListeners();
        },
        url: Urls.aFetchHomePageData,
        param: {Urls.aMyUserId: PrefService.userId, Urls.aStart: postList.length, Urls.aLimit: paginationLimit});
  }

  void fetchScrollData() {
    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent) {
        if (!isLoading) {
          fetchFeedData();
        }
      }
    });
  }

  void onCommentBtnClick(Posts post) {
    Get.bottomSheet(CommentSheet(post: post), isScrollControlled: true).then((value) {
      notifyListeners();
    });
  }

  void onCreatePost() {
    Get.bottomSheet(
      const CreatePostScreen(),
      isScrollControlled: true,
      backgroundColor: ColorRes.white,
      barrierColor: ColorRes.white,
      enableDrag: false,
    );
  }

  onMoreBtnClick(MoreBtnValue value, Posts posts) {
    if (MoreBtnValue.share == value) {
    } else if (MoreBtnValue.report == value) {
      Get.bottomSheet(
          ReportSheet(
            reportId: posts.id,
            profileImage: CommonFun.getProfileImage(images: posts.user?.images),
            age: posts.user?.age,
            fullName: posts.user?.fullname,
            address: posts.user?.live,
            type: 2,
          ),
          isScrollControlled: true);
    } else if (MoreBtnValue.delete == value) {
      ApiProvider().callPost(
        completion: (response) {
          DeletePost deletePost = DeletePost.fromJson(response);
          postList.removeWhere((element) {
            return element.id == deletePost.data?.id;
          });
          notifyListeners();
        },
        url: Urls.aDeleteMyPost,
        param: {Urls.aUserId: PrefService.userId, Urls.aPostId: posts.id},
      );
    }
  }
}

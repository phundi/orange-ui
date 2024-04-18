import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/confirmation_dialog.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/social/feed.dart';
import 'package:orange_ui/model/social/story/fetch_stories.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/comment_sheet/comment_sheet.dart';
import 'package:orange_ui/screen/create_post_screen/create_post_screen.dart';
import 'package:orange_ui/screen/live_grid_screen/live_grid_screen.dart';
import 'package:orange_ui/screen/notification_screen/notification_screen.dart';
import 'package:orange_ui/screen/search_screen/search_screen.dart';
import 'package:orange_ui/screen/user_report_screen/report_sheet.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:stacked/stacked.dart';

enum MoreBtnValue { report, delete, share }

class FeedScreenViewModel extends BaseViewModel {
  List<Posts> postList = [];
  List<RegistrationUserData> stories = [];
  bool isLoading = true;
  ScrollController scrollController = ScrollController();
  MoreBtnValue moreBtnValue = MoreBtnValue.share;

  RegistrationUserData? userData;

  // For Camera Screen
  List<CameraDescription> cameras = [];

  void init() {
    prefData();
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
          stories.sort((a, b) {
            if (a.isAllStoryShown()) {
              return 1;
            }
            return -1;
          });
          notifyListeners();
        },
        url: Urls.aFetchHomePageData,
        param: {
          Urls.aMyUserId: PrefService.userId,
          Urls.aStart: postList.length,
          Urls.aLimit: paginationLimit
        });
  }

  void fetchStories() {
    ApiProvider().callPost(
        completion: (response) {
          FetchStories fetchStories = FetchStories.fromJson(response);
          stories = fetchStories.data ?? [];
          stories.sort((a, b) {
            if (a.isAllStoryShown()) {
              return 1;
            }
            return -1;
          });
          notifyListeners();
        },
        url: Urls.aFetchStories,
        param: {Urls.aMyUserId: PrefService.userId});
  }

  void getProfile() {
    ApiProvider()
        .getProfile(myUserID: PrefService.userId, userID: PrefService.userId)
        .then((value) {
      userData = value?.data;
      notifyListeners();
    });
  }

  void fetchScrollData() {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (!isLoading) {
          fetchFeedData();
        }
      }
    });
  }

  void onCommentBtnClick(Posts post) {
    Get.bottomSheet(CommentSheet(post: post), isScrollControlled: true)
        .then((value) {
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
            userData: posts.user,
            reportType: 2,
          ),
          isScrollControlled: true);
    } else if (MoreBtnValue.delete == value) {
      Get.dialog(
        ConfirmationDialog(
          onTap: () {
            postList.removeWhere((element) => element.id == posts.id);
            notifyListeners();
            ApiProvider().callPost(
              completion: (response) {},
              url: Urls.aDeleteMyPost,
              param: {Urls.aUserId: PrefService.userId, Urls.aPostId: posts.id},
            );
          },
          description: S.current.areYouSureYouWantToDeleteThePost,
          heading: S.current.deletePost,
          dialogSize: 2,
          padding: const EdgeInsets.all(50),
        ),
      );
    }
  }

  void onNotificationTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const NotificationScreen());
  }

  void onLivesBtnClick() {
    Get.to(() => const LiveGridScreen());
  }

  void onSearchTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const SearchScreen());
  }

  void prefData() async {
    userData = await PrefService.getUserData();
    notifyListeners();
    if (cameras.isEmpty) {
      cameras = await availableCameras();
    }
  }
}

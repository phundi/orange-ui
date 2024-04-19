import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/model/social/post/add_comment.dart';
import 'package:orange_ui/model/social/post/fetch_post_by_user.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:stacked/stacked.dart';

class PostScreenViewModel extends BaseViewModel {
  RegistrationUserData? userData;
  List<Post> posts = [];
  bool isLoading = true;

  init() {
    fetchPostByUse();
  }

  PostScreenViewModel(this.userData);

  void fetchPostByUse() {
    isLoading = true;
    ApiProvider().callPost(
        completion: (response) {
          isLoading = false;
          FetchPostByUser fetchPostByUser = FetchPostByUser.fromJson(response);
          if (posts.isEmpty) {
            posts = fetchPostByUser.data ?? [];
          } else {
            posts.addAll(fetchPostByUser.data ?? []);
          }
          notifyListeners();
        },
        url: Urls.aFetchPostByUser,
        param: {
          Urls.aMyUserId: PrefService.userId,
          Urls.aUserId: userData?.id,
          Urls.aStart: posts.length,
          Urls.aLimit: paginationLimit
        });
  }
}

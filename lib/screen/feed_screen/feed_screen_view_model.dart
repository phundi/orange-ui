import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/model/social/feed.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:stacked/stacked.dart';

class FeedScreenViewModel extends BaseViewModel {
  List<Posts> posts = [];
  List<UsersStories> stories = [];
  bool isLoading = true;

  void init() {
    print('init()');
    fetchFeedData();
  }

  void fetchFeedData() {
    isLoading = true;
    ApiProvider().callPost(
        completion: (response) {
          isLoading = false;
          Feed feed = Feed.fromJson(response);
          posts = feed.data?.posts ?? [];
          stories = feed.data?.usersStories ?? [];
          notifyListeners();
        },
        url: Urls.aFetchHomePageData,
        param: {
          Urls.aMyUserId: PrefService.userId,
          Urls.aStart: posts.length,
          Urls.aLimit: 10,
        });
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:orange_ui/model/chat_and_live_stream/add_live_stream_history.dart';
import 'package:orange_ui/model/chat_and_live_stream/agora.dart';
import 'package:orange_ui/model/chat_and_live_stream/apply_for_live.dart';
import 'package:orange_ui/model/chat_and_live_stream/fetch_live_stream_history.dart';
import 'package:orange_ui/model/fetch_redeem_request.dart';
import 'package:orange_ui/model/get_diamond_pack.dart';
import 'package:orange_ui/model/get_explore_screen.dart';
import 'package:orange_ui/model/get_interest.dart';
import 'package:orange_ui/model/map/fetch_user_coordinate.dart';
import 'package:orange_ui/model/notification/admin_notification.dart';
import 'package:orange_ui/model/notification/notify_like_user.dart';
import 'package:orange_ui/model/notification/on_off_anonymous.dart';
import 'package:orange_ui/model/notification/on_off_notification.dart';
import 'package:orange_ui/model/notification/on_off_show_me_map.dart';
import 'package:orange_ui/model/notification/user_notification.dart';
import 'package:orange_ui/model/report.dart';
import 'package:orange_ui/model/search/search_user.dart';
import 'package:orange_ui/model/search/search_user_by_id.dart';
import 'package:orange_ui/model/setting.dart';
import 'package:orange_ui/model/store_file_give_path.dart';
import 'package:orange_ui/model/update_saved_profile.dart';
import 'package:orange_ui/model/user/delete_account.dart';
import 'package:orange_ui/model/user/get_profile.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/model/user_block_list.dart';
import 'package:orange_ui/model/verification.dart';
import 'package:orange_ui/model/wallet/minus_coin_from_wallet.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/pref_res.dart';
import 'package:orange_ui/utils/urls.dart';

class ApiProvider {
  Map<String, String> headers = {Urls.aApiKeyName: ConstRes.apiKey};

  Future<RegistrationUser> registration({
    required String? email,
    required String? fullName,
    required String? deviceToken,
    required int? loginType,
    String? password,
  }) async {
    Map<String, dynamic> map = {};
    map[Urls.aFullName] = fullName;
    map[Urls.aDeviceToken] = deviceToken;
    map[Urls.aDeviceType] = Platform.isAndroid ? Urls.aOne : Urls.aTwo;
    map[Urls.aLoginType] = loginType.toString();
    map[Urls.aIdentity] = email;
    map[Urls.aInterests] = '';
    if (password != null && password.isNotEmpty) {
      map[Urls.aPassword] = password;
    }
    http.Response response = await http.post(Uri.parse(Urls.aRegister),
        headers: {Urls.aApiKeyName: ConstRes.apiKey}, body: map);
    return RegistrationUser.fromJson(jsonDecode(response.body));
  }

  Future<GetInterest?> getInterest() async {
    http.Response response = await http.post(Uri.parse(Urls.aGetInterests),
        headers: {Urls.aApiKeyName: ConstRes.apiKey});
    await PrefService.saveString(PrefConst.interest, response.body);
    return GetInterest.fromJson(jsonDecode(response.body));
  }

  Future<ApplyForLive> applyForLive(File? introVideo, String aboutYou,
      String languages, String socialLinks) async {
    var request = http.MultipartRequest(
      Urls.aPost,
      Uri.parse(Urls.aApplyForLive),
    );
    request.headers.addAll({
      Urls.aApiKeyName: ConstRes.apiKey,
    });
    request.fields[Urls.aUserId] = PrefService.userId.toString();
    request.fields[Urls.aSocialLink] = socialLinks;
    if (introVideo != null) {
      request.files.add(
        http.MultipartFile(Urls.aIntroVideo,
            introVideo.readAsBytes().asStream(), introVideo.lengthSync(),
            filename: introVideo.path.split("/").last),
      );
    }
    request.fields[Urls.aLanguages] = languages;
    request.fields[Urls.aAboutYou] = aboutYou;

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    ApplyForLive applyForLive = ApplyForLive.fromJson(responseJson);
    return applyForLive;
  }

  Future<RegistrationUser> updateProfile(
      {List<File>? images,
      String? live,
      String? bio,
      List<String>? interest,
      String? age,
      String? latitude,
      String? longitude,
      String? instagram,
      String? facebook,
      String? youtube,
      String? fullName,
      String? userName,
      List<String>? deleteImageIds,
      int? gender,
      String? about}) async {
    var request = http.MultipartRequest(
      Urls.aPost,
      Uri.parse(Urls.aUpdateProfile),
    );
    request.headers.addAll({
      Urls.aApiKeyName: ConstRes.apiKey,
    });
    request.fields[Urls.aUserId] = PrefService.userId.toString();
    if (live != null) {
      request.fields[Urls.aLive] = live;
    }
    if (bio != null) {
      request.fields[Urls.aBio] = bio;
    }
    if (age != null) {
      request.fields[Urls.aAge] = age;
    }
    if (fullName != null) {
      request.fields[Urls.aFullName] = fullName;
    }
    if (userName != null) {
      request.fields[Urls.aUserName] = userName;
    }
    if (instagram != null) {
      request.fields[Urls.aInstagram] = instagram;
    }
    if (facebook != null) {
      request.fields[Urls.aFacebook] = facebook;
    }
    if (youtube != null) {
      request.fields[Urls.aYoutube] = youtube;
    }
    if (latitude != null) {
      request.fields[Urls.aLatitude] = latitude;
    }
    if (longitude != null) {
      request.fields[Urls.aLongitude] = longitude;
    }
    if (interest != null) {
      request.fields[Urls.aInterests] = interest.join(",");
    }
    if (gender != null) {
      request.fields[Urls.aGender] = '$gender';
    }
    if (about != null) {
      request.fields[Urls.aAbout] = about;
    }
    List<http.MultipartFile> newList = <http.MultipartFile>[];
    Map<String, String> map = {};

    if (deleteImageIds != null) {
      for (int i = 0; i < deleteImageIds.length; i++) {
        map['${Urls.aDeleteImagesId}[$i]'] = deleteImageIds[i];
      }
    }
    request.fields.addAll(map);
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        File imageFile = images[i];
        var multipartFile = http.MultipartFile(Urls.aImages,
            imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
            filename: imageFile.path.split('/').last);
        newList.add(multipartFile);
      }
    }
    request.files.addAll(newList);
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    RegistrationUser updateProfile = RegistrationUser.fromJson(responseJson);
    await PrefService.saveUser(updateProfile.data);
    PrefService.updateFirebase();
    return updateProfile;
  }

  Future<GetProfile?> getProfile({int? userID}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.aGetProfile), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aUserId: userID.toString(),
      Urls.aMyUserId: PrefService.userId.toString(),
    });
    return GetProfile.fromJson(jsonDecode(response.body));
  }

  Future<OnOffNotification> onOffNotification(int state) async {
    http.Response response = await http.post(Uri.parse(Urls.aOnOffNotification),
        headers: {
          Urls.aApiKeyName: ConstRes.apiKey
        },
        body: {
          Urls.aUserId: PrefService.userId.toString(),
          Urls.aState: state.toString()
        });
    return OnOffNotification.fromJson(jsonDecode(response.body));
  }

  Future<OnOffShowMeMap> onOffShowMeOnMap(int state) async {
    http.Response response = await http.post(Uri.parse(Urls.aOnOffShowMeOnMap),
        headers: {
          Urls.aApiKeyName: ConstRes.apiKey
        },
        body: {
          Urls.aUserId: PrefService.userId.toString(),
          Urls.aState: state.toString()
        });
    return OnOffShowMeMap.fromJson(jsonDecode(response.body));
  }

  Future<OnOffAnonymous> onOffAnonymous(int? state) async {
    http.Response response = await http.post(Uri.parse(Urls.aOnOffAnonymous),
        headers: {
          Urls.aApiKeyName: ConstRes.apiKey
        },
        body: {
          Urls.aUserId: PrefService.userId.toString(),
          Urls.aState: state.toString()
        });

    return OnOffAnonymous.fromJson(jsonDecode(response.body));
  }

  Future<Report> addReport(String reason, String description, int? id) async {
    http.Response response =
        await http.post(Uri.parse(Urls.aAddReport), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aReason: reason,
      Urls.aDescription: description,
      Urls.aUserId: id.toString()
    });
    return Report.fromJson(jsonDecode(response.body));
  }

  Future<AdminNotification> adminNotification(int start) async {
    http.Response response = await http.post(
        Uri.parse(Urls.aGetAdminNotification),
        headers: {Urls.aApiKeyName: ConstRes.apiKey},
        body: {Urls.aStart: start.toString(), Urls.aCount: Urls.aFifteen});
    return AdminNotification.fromJson(jsonDecode(response.body));
  }

  Future<UserNotification> getUserNotification(int start) async {
    http.Response response =
        await http.post(Uri.parse(Urls.aGetUserNotification), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aUserId: PrefService.userId.toString(),
      Urls.aStart: start.toString(),
      Urls.aCount: Urls.aFifteen
    });
    return UserNotification.fromJson(jsonDecode(response.body));
  }

  Future<Setting> getSettingData() async {
    http.Response response = await http.post(
      Uri.parse(Urls.aGetSettingData),
      headers: {Urls.aApiKeyName: ConstRes.apiKey},
    );
    Setting setting = Setting.fromJson(jsonDecode(response.body));
    await PrefService.saveSettingData(setting.data);
    return setting;
  }

  Future<SearchUser> searchUser(
      {required String searchKeyword, required int start}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.aSearchUsers), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aKeyword: searchKeyword,
      Urls.aStart: start.toString(),
      Urls.aCount: '$paginationLimit'
    });
    return SearchUser.fromJson(jsonDecode(response.body));
  }

  Future<SearchUserById> searchUserById(
      {required String searchKeyword,
      int? interestId,
      required int start}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.aSearchUsersForInterest), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aKeyword: searchKeyword,
      Urls.aStart: start.toString(),
      Urls.aCount: Urls.aFifteen,
      Urls.aInterestId: interestId.toString()
    });
    return SearchUserById.fromJson(jsonDecode(response.body));
  }

  Future<UpdateSavedProfile> updateLikedProfile(int? profileId) async {
    var userData = await PrefService.getUserData();
    String? likedProfile = userData?.likedprofile;
    List<int> list = [];
    if (likedProfile != null &&
        likedProfile.isNotEmpty &&
        !likedProfile.contains(profileId.toString())) {
      likedProfile += ',$profileId';
    } else {
      if (likedProfile == null || likedProfile.isEmpty) {
        likedProfile = profileId.toString();
      } else if (likedProfile.contains(profileId.toString())) {
        for (int i = 0; i < likedProfile.split(',').length; i++) {
          list.add(int.parse(likedProfile.split(',')[i]));
        }
        for (int i = 0; i < likedProfile.split(',').length; i++) {
          if (likedProfile.split(',')[i] == profileId.toString()) {
            list.removeAt(i);
            break;
          }
        }
        likedProfile = list.join(",");
      }
    }
    http.Response response =
        await http.post(Uri.parse(Urls.aUpdateLikedProfile), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aUserId: PrefService.userId.toString(),
      Urls.aProfiles: likedProfile,
    });

    UpdateSavedProfile updateSavedProfile =
        UpdateSavedProfile.fromJson(jsonDecode(response.body));
    PrefService.saveUser(updateSavedProfile.data);
    return updateSavedProfile;
  }

  Future<UpdateSavedProfile> updateSaveProfile(int? profileId) async {
    var userData = await PrefService.getUserData();
    String? savedProfile = userData?.savedprofile;
    List<int> savedProfileList = [];
    if (savedProfile != null &&
        savedProfile.isNotEmpty &&
        !savedProfile.contains(profileId.toString())) {
      savedProfile += ',$profileId';
    } else {
      if (savedProfile == null || savedProfile.isEmpty) {
        savedProfile = profileId.toString();
      } else if (savedProfile.contains(profileId.toString())) {
        for (int i = 0; i < savedProfile.split(',').length; i++) {
          savedProfileList.add(int.parse(savedProfile.split(',')[i]));
        }
        for (int i = 0; i < savedProfile.split(',').length; i++) {
          if (savedProfile.split(',')[i] == profileId.toString()) {
            savedProfileList.removeAt(i);
            break;
          }
        }
        savedProfile = savedProfileList.join(",");
      }
    }

    http.Response response = await http
        .post(Uri.parse(Urls.aUpdateSavedProfile), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aUserId: PrefService.userId.toString(),
      Urls.aProfiles: savedProfile
    });
    UpdateSavedProfile updateSavedProfile =
        UpdateSavedProfile.fromJson(jsonDecode(response.body));
    PrefService.saveUser(updateSavedProfile.data);
    return updateSavedProfile;
  }

  Future<FetchLiveStreamHistory> fetchAllLiveStreamHistory(int starting) async {
    http.Response response =
        await http.post(Uri.parse(Urls.aFetchAllLiveStreamHistory), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aUserId: PrefService.userId.toString(),
      Urls.aStart: '$starting',
      Urls.aCount: Urls.aFifteen
    });
    return FetchLiveStreamHistory.fromJson(jsonDecode(response.body));
  }

  Future<Verification> applyForVerification(
      File? photo, File? docImage, String fullName, String docType) async {
    var request = http.MultipartRequest(
      Urls.aPost,
      Uri.parse(Urls.aApplyForVerification),
    );
    request.headers.addAll({
      Urls.aApiKeyName: ConstRes.apiKey,
    });
    request.fields[Urls.aUserId] = PrefService.userId.toString();
    request.fields[Urls.aDocumentType] = docType;
    if (photo != null) {
      request.files.add(
        http.MultipartFile(
            Urls.aSelfie, photo.readAsBytes().asStream(), photo.lengthSync(),
            filename: photo.path.split("/").last),
      );
    }
    if (docImage != null) {
      request.files.add(
        http.MultipartFile(Urls.aDocument, docImage.readAsBytes().asStream(),
            docImage.lengthSync(),
            filename: docImage.path.split("/").last),
      );
    }
    request.fields[Urls.aFullName] = fullName;

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    Verification applyForVerification = Verification.fromJson(responseJson);
    return applyForVerification;
  }

  Future<DeleteAccount> deleteAccount(int? deleteId) async {
    http.Response response = await http.post(Uri.parse(Urls.aDeleteMyAccount),
        headers: {Urls.aApiKeyName: ConstRes.apiKey},
        body: {Urls.aUserId: deleteId.toString()});
    return DeleteAccount.fromJson(jsonDecode(response.body));
  }

  Future<StoreFileGivePath> getStoreFileGivePath({File? image}) async {
    var request = http.MultipartRequest(
      Urls.aPost,
      Uri.parse(Urls.aStorageFileGivePath),
    );
    request.headers.addAll({
      Urls.aApiKeyName: ConstRes.apiKey,
    });
    if (image != null) {
      request.files.add(
        http.MultipartFile(
            Urls.aFile, image.readAsBytes().asStream(), image.lengthSync(),
            filename: image.path.split("/").last),
      );
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    StoreFileGivePath applyForVerification =
        StoreFileGivePath.fromJson(responseJson);
    return applyForVerification;
  }

  Future<MinusCoinFromWallet> minusCoinFromWallet(int? amount) async {
    http.Response response = await http
        .post(Uri.parse(Urls.aMinusCoinsFromWallet), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aUserId: PrefService.userId.toString(),
      Urls.aAmount: amount.toString()
    });
    return MinusCoinFromWallet.fromJson(jsonDecode(response.body));
  }

  Future<MinusCoinFromWallet> addCoinFromWallet(int? amount) async {
    http.Response response = await http.post(
      Uri.parse(Urls.aAddCoinsToWallet),
      headers: {Urls.aApiKeyName: ConstRes.apiKey},
      body: {
        Urls.aUserId: PrefService.userId.toString(),
        Urls.aAmount: amount.toString()
      },
    );

    return MinusCoinFromWallet.fromJson(jsonDecode(response.body));
  }

  Future<GetDiamondPack> getDiamondPack() async {
    http.Response response =
        await http.post(Uri.parse(Urls.aGetDiamondPacks), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aUserId: PrefService.userId.toString(),
      Urls.aStart: '0',
      Urls.aCount: Urls.aFifteen
    });
    return GetDiamondPack.fromJson(jsonDecode(response.body));
  }

  Future<AddLiveStreamHistory> addLiveStreamHistory(
      {required String streamFor,
      required String startedAt,
      required String amountCollected}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.aAddLiveStreamHistory), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aUserId: PrefService.userId.toString(),
      Urls.aStreamedFor: streamFor,
      Urls.aStartedAt: startedAt,
      Urls.aAmountCollected: amountCollected
    });
    return AddLiveStreamHistory.fromJson(jsonDecode(response.body));
  }

  Future<GetProfile> getRandomProfile({required int gender}) async {
    http.Response response = await http.post(Uri.parse(Urls.aGetRandomProfile),
        headers: {
          Urls.aApiKeyName: ConstRes.apiKey
        },
        body: {
          Urls.aUserId: PrefService.userId.toString(),
          Urls.aGender: gender.toString()
        });
    return GetProfile.fromJson(jsonDecode(response.body));
  }

  Future<GetExploreScreen> getExplorePageProfileList() async {
    http.Response response = await http.post(
        Uri.parse(Urls.aGetExplorePageProfileList),
        headers: {Urls.aApiKeyName: ConstRes.apiKey},
        body: {Urls.aUserId: PrefService.userId.toString()});
    return GetExploreScreen.fromJson(jsonDecode(response.body));
  }

  Future<FetchRedeemRequest> fetchRedeemRequest() async {
    http.Response response = await http.post(
        Uri.parse(Urls.aFetchMyRedeemRequests),
        headers: {Urls.aApiKeyName: ConstRes.apiKey},
        body: {Urls.aUserId: PrefService.userId.toString()});
    return FetchRedeemRequest.fromJson(jsonDecode(response.body));
  }

  Future<UserBlockList> updateBlockList(int? blockProfileId) async {
    var userData = await PrefService.getUserData();
    String? blockProfile = userData?.blockedUsers;
    List<int> blockProfileList = [];
    if (blockProfile != null &&
        blockProfile.isNotEmpty &&
        !blockProfile.contains(blockProfileId.toString())) {
      blockProfile += ',$blockProfileId';
    } else {
      if (blockProfile == null || blockProfile.isEmpty) {
        blockProfile = blockProfileId.toString();
      } else if (blockProfile.contains(blockProfileId.toString())) {
        for (int i = 0; i < blockProfile.split(',').length; i++) {
          blockProfileList.add(int.parse(blockProfile.split(',')[i]));
        }
        for (int i = 0; i < blockProfile.split(',').length; i++) {
          if (blockProfile.split(',')[i] == blockProfileId.toString()) {
            blockProfileList.removeAt(i);
            break;
          }
        }
        blockProfile = blockProfileList.join(",");
      }
    }

    http.Response response = await http.post(Uri.parse(Urls.aUpdateBlockList),
        headers: {
          Urls.aApiKeyName: ConstRes.apiKey
        },
        body: {
          Urls.aUserId: PrefService.userId.toString(),
          Urls.aBlockedUsers: blockProfile
        });
    UserBlockList updateBlockProfile =
        UserBlockList.fromJson(jsonDecode(response.body));
    PrefService.saveUser(updateBlockProfile.data);
    return updateBlockProfile;
  }

  Future<FetchUserCoordinate> getUserByLatLong(
      {required double latitude,
      required double longitude,
      required int km}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.aFetchUsersByCoordinates), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aLat: latitude.toString(),
      Urls.aLong: longitude.toString(),
      Urls.aKm: km.toString()
    });
    return FetchUserCoordinate.fromJson(jsonDecode(response.body));
  }

  Future<GetProfile> getUserDetail({required String email}) async {
    http.Response response = await http.post(Uri.parse(Urls.aGetUserDetails),
        headers: {Urls.aApiKeyName: ConstRes.apiKey},
        body: {Urls.aEmail: email});
    return GetProfile.fromJson(jsonDecode(response.body));
  }

  Future<NotifyLikeUser> notifyLikeUser(
      {required int? userId, required int type}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.aNotifyLikedUser), headers: {
      Urls.aApiKeyName: ConstRes.apiKey
    }, body: {
      Urls.aUserId: userId.toString(),
      Urls.aDataUserId: PrefService.userId.toString(),
      Urls.aType: type.toString()
    });
    return NotifyLikeUser.fromJson(jsonDecode(response.body));
  }

  Future pushNotification(
      {required String title,
      required String body,
      required Map<String, dynamic> data,
      required String token}) async {
    await http
        .post(Uri.parse(Urls.aNotificationUrl),
            headers: {
              Urls.aApiKeyName: ConstRes.apiKey,
              'content-type': 'application/json'
            },
            body: json.encode({
              'message': {
                'token': token,
                'data': data,
                // 'notification': {'title': title, 'body': body},
              }
            }))
        .then((value) {
      log('Notification : ${value.body}');
    });
  }

  Future<Report> logoutUser() async {
    http.Response response = await http.post(Uri.parse(Urls.aLogoutUser),
        headers: {Urls.aApiKeyName: ConstRes.apiKey},
        body: {Urls.aUserId: PrefService.userId.toString()});
    return Report.fromJson(jsonDecode(response.body));
  }

  Future<Agora> agoraListStreamingCheck(
      String channelName, String authToken, String agoraAppId) async {
    log('$channelName\n$agoraAppId\n$authToken');
    http.Response response = await http.get(
        Uri.parse(
            'https://api.agora.io/dev/v1/channel/user/$agoraAppId/$channelName'),
        headers: {'Authorization': 'Basic $authToken'});
    return Agora.fromJson(jsonDecode(response.body));
  }

  Future<SearchUser> fetchSavedProfiles() async {
    http.Response response = await http.post(
        Uri.parse(Urls.aFetchSavedProfiles),
        headers: {Urls.aApiKeyName: ConstRes.apiKey},
        body: {Urls.aUserId: PrefService.userId.toString()});
    // print(response.body);
    return SearchUser.fromJson(jsonDecode(response.body));
  }

  Future<SearchUser> fetchLikedProfiles() async {
    http.Response response = await http.post(
        Uri.parse(Urls.aFetchLikedProfiles),
        headers: {Urls.aApiKeyName: ConstRes.apiKey},
        body: {Urls.aUserId: PrefService.userId.toString()});
    // print(response.body);
    return SearchUser.fromJson(jsonDecode(response.body));
  }

  Future<SearchUser> fetchBlockedProfiles() async {
    http.Response response = await http.post(
        Uri.parse(Urls.aFetchBlockedProfiles),
        headers: {Urls.aApiKeyName: ConstRes.apiKey},
        body: {Urls.aUserId: PrefService.userId.toString()});
    // print(response.body);
    return SearchUser.fromJson(jsonDecode(response.body));
  }

  void callPost({
    required Function(Object response) completion,
    required String url,
    Map<String, dynamic>? param,
  }) {
    Map<String, String> params = {};
    param?.forEach((key, value) {
      params[key] = "$value";
    });
    log("❗️{URL}:  $url");
    log("❗️{PARAMETERS}:  $params");
    http.post(Uri.parse(url), headers: headers, body: params).then(
      (value) {
        log('❗️RESPONSE:  ${value.body}');
        var response = jsonDecode(value.body);
        completion.call(response);
      },
    );
  }

  void multiPartCallApi(
      {required String url,
      Map<String, dynamic>? param,
      Map<String, List<XFile?>>? filesMap,
      required Function(Object response) completion}) {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    Map<String, String> params = {};
    param?.forEach((key, value) {
      if (value is List) {
        for (int i = 0; i < value.length; i++) {
          params['$key[$i]'] = value[i];
        }
      } else {
        params[key] = "$value";
      }
    });

    request.fields.addAll(params);
    request.headers.addAll(headers);
    if (filesMap != null) {
      filesMap.forEach((keyName, files) {
        for (var xFile in files) {
          if (xFile != null && xFile.path.isNotEmpty) {
            File file = File(xFile.path);
            var multipartFile = http.MultipartFile(
                keyName, file.readAsBytes().asStream(), file.lengthSync(),
                filename: xFile.name);
            request.files.add(multipartFile);
          }
        }
      });
    }
    // log(param.toString());
    // log(filesMap.toString());
    request.send().then((value) {
      // log('StatusCode :: ${value.statusCode}');
      value.stream.bytesToString().then((respStr) {
        var response = jsonDecode(respStr);
        // log(respStr);
        completion(response);
      });
    });
  }
}

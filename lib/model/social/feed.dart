import 'package:orange_ui/model/user/registration_user.dart';

class Feed {
  Feed({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Feed.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;

  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    List<UsersStories>? usersStories,
    List<Posts>? posts,
  }) {
    _usersStories = usersStories;
    _posts = posts;
  }

  Data.fromJson(dynamic json) {
    if (json['users_stories'] != null) {
      _usersStories = [];
      json['users_stories'].forEach((v) {
        _usersStories?.add(UsersStories.fromJson(v));
      });
    }
    if (json['posts'] != null) {
      _posts = [];
      json['posts'].forEach((v) {
        _posts?.add(Posts.fromJson(v));
      });
    }
  }
  List<UsersStories>? _usersStories;
  List<Posts>? _posts;

  List<UsersStories>? get usersStories => _usersStories;
  List<Posts>? get posts => _posts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_usersStories != null) {
      map['users_stories'] = _usersStories?.map((v) => v.toJson()).toList();
    }
    if (_posts != null) {
      map['posts'] = _posts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Posts {
  Posts({
    int? id,
    int? userId,
    String? description,
    String? interestIds,
    int? commentsCount,
    int? likesCount,
    String? hashtags,
    String? createdAt,
    String? updatedAt,
    int? isLike,
    List<Content>? content,
    RegistrationUserData? user,
  }) {
    _id = id;
    _userId = userId;
    _description = description;
    _interestIds = interestIds;
    _commentsCount = commentsCount;
    _likesCount = likesCount;
    _hashtags = hashtags;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _isLike = isLike;
    _content = content;
    _user = user;
  }

  Posts.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _description = json['description'];
    _interestIds = json['interest_ids'];
    _commentsCount = json['comments_count'];
    _likesCount = json['likes_count'];
    _hashtags = json['hashtags'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _isLike = json['is_like'];
    if (json['content'] != null) {
      _content = [];
      json['content'].forEach((v) {
        _content?.add(Content.fromJson(v));
      });
    }
    _user = json['user'] != null ? RegistrationUserData.fromJson(json['user']) : null;
  }
  int? _id;
  int? _userId;
  String? _description;
  String? _interestIds;
  int? _commentsCount;
  int? _likesCount;
  String? _hashtags;
  String? _createdAt;
  String? _updatedAt;
  int? _isLike;
  List<Content>? _content;
  RegistrationUserData? _user;

  int? get id => _id;
  int? get userId => _userId;
  String? get description => _description;
  String? get interestIds => _interestIds;
  int? get commentsCount => _commentsCount;
  int? get likesCount => _likesCount;
  String? get hashtags => _hashtags;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get isLike => _isLike;
  List<Content>? get content => _content;
  RegistrationUserData? get user => _user;

  void setLikesCount(int value) {
    _likesCount = (_likesCount ?? 0) + value;
  }

  void setCommentCount(int value) {
    _commentsCount = (_commentsCount ?? 0) + value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['description'] = _description;
    map['interest_ids'] = _interestIds;
    map['comments_count'] = _commentsCount;
    map['likes_count'] = _likesCount;
    map['hashtags'] = _hashtags;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['is_like'] = _isLike;
    if (_content != null) {
      map['content'] = _content?.map((v) => v.toJson()).toList();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class Content {
  Content({
    int? id,
    int? postId,
    int? contentType,
    String? content,
    String? thumbnail,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _postId = postId;
    _contentType = contentType;
    _content = content;
    _thumbnail = thumbnail;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Content.fromJson(dynamic json) {
    _id = json['id'];
    _postId = json['post_id'];
    _contentType = json['content_type'];
    _content = json['content'];
    _thumbnail = json['thumbnail'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _postId;
  int? _contentType;
  String? _content;
  String? _thumbnail;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get postId => _postId;
  int? get contentType => _contentType;
  String? get content => _content;
  String? get thumbnail => _thumbnail;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['post_id'] = _postId;
    map['content_type'] = _contentType;
    map['content'] = _content;
    map['thumbnail'] = _thumbnail;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class UsersStories {
  UsersStories({
    int? id,
    int? isBlock,
    int? gender,
    dynamic savedprofile,
    dynamic likedprofile,
    String? interests,
    int? age,
    String? identity,
    String? fullname,
    dynamic instagram,
    dynamic youtube,
    dynamic facebook,
    String? live,
    String? bio,
    dynamic about,
    String? lattitude,
    String? longitude,
    int? loginType,
    String? deviceToken,
    dynamic blockedUsers,
    int? wallet,
    int? totalCollected,
    int? totalStreams,
    int? deviceType,
    int? isNotification,
    int? isVerified,
    int? showOnMap,
    int? anonymous,
    int? isVideoCall,
    int? canGoLive,
    int? isLiveNow,
    int? isFake,
    dynamic password,
    int? following,
    int? followers,
    String? createdAt,
    String? updateAt,
    List<Stories>? stories,
  }) {
    _id = id;
    _isBlock = isBlock;
    _gender = gender;
    _savedprofile = savedprofile;
    _likedprofile = likedprofile;
    _interests = interests;
    _age = age;
    _identity = identity;
    _fullname = fullname;
    _instagram = instagram;
    _youtube = youtube;
    _facebook = facebook;
    _live = live;
    _bio = bio;
    _about = about;
    _lattitude = lattitude;
    _longitude = longitude;
    _loginType = loginType;
    _deviceToken = deviceToken;
    _blockedUsers = blockedUsers;
    _wallet = wallet;
    _totalCollected = totalCollected;
    _totalStreams = totalStreams;
    _deviceType = deviceType;
    _isNotification = isNotification;
    _isVerified = isVerified;
    _showOnMap = showOnMap;
    _anonymous = anonymous;
    _isVideoCall = isVideoCall;
    _canGoLive = canGoLive;
    _isLiveNow = isLiveNow;
    _isFake = isFake;
    _password = password;
    _following = following;
    _followers = followers;
    _createdAt = createdAt;
    _updateAt = updateAt;
    _stories = stories;
  }

  UsersStories.fromJson(dynamic json) {
    _id = json['id'];
    _isBlock = json['is_block'];
    _gender = json['gender'];
    _savedprofile = json['savedprofile'];
    _likedprofile = json['likedprofile'];
    _interests = json['interests'];
    _age = json['age'];
    _identity = json['identity'];
    _fullname = json['fullname'];
    _instagram = json['instagram'];
    _youtube = json['youtube'];
    _facebook = json['facebook'];
    _live = json['live'];
    _bio = json['bio'];
    _about = json['about'];
    _lattitude = json['lattitude'];
    _longitude = json['longitude'];
    _loginType = json['login_type'];
    _deviceToken = json['device_token'];
    _blockedUsers = json['blocked_users'];
    _wallet = json['wallet'];
    _totalCollected = json['total_collected'];
    _totalStreams = json['total_streams'];
    _deviceType = json['device_type'];
    _isNotification = json['is_notification'];
    _isVerified = json['is_verified'];
    _showOnMap = json['show_on_map'];
    _anonymous = json['anonymous'];
    _isVideoCall = json['is_video_call'];
    _canGoLive = json['can_go_live'];
    _isLiveNow = json['is_live_now'];
    _isFake = json['is_fake'];
    _password = json['password'];
    _following = json['following'];
    _followers = json['followers'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
    if (json['stories'] != null) {
      _stories = [];
      json['stories'].forEach((v) {
        _stories?.add(Stories.fromJson(v));
      });
    }
  }
  int? _id;
  int? _isBlock;
  int? _gender;
  dynamic _savedprofile;
  dynamic _likedprofile;
  String? _interests;
  int? _age;
  String? _identity;
  String? _fullname;
  dynamic _instagram;
  dynamic _youtube;
  dynamic _facebook;
  String? _live;
  String? _bio;
  dynamic _about;
  String? _lattitude;
  String? _longitude;
  int? _loginType;
  String? _deviceToken;
  dynamic _blockedUsers;
  int? _wallet;
  int? _totalCollected;
  int? _totalStreams;
  int? _deviceType;
  int? _isNotification;
  int? _isVerified;
  int? _showOnMap;
  int? _anonymous;
  int? _isVideoCall;
  int? _canGoLive;
  int? _isLiveNow;
  int? _isFake;
  dynamic _password;
  int? _following;
  int? _followers;
  String? _createdAt;
  String? _updateAt;
  List<Stories>? _stories;

  int? get id => _id;
  int? get isBlock => _isBlock;
  int? get gender => _gender;
  dynamic get savedprofile => _savedprofile;
  dynamic get likedprofile => _likedprofile;
  String? get interests => _interests;
  int? get age => _age;
  String? get identity => _identity;
  String? get fullname => _fullname;
  dynamic get instagram => _instagram;
  dynamic get youtube => _youtube;
  dynamic get facebook => _facebook;
  String? get live => _live;
  String? get bio => _bio;
  dynamic get about => _about;
  String? get lattitude => _lattitude;
  String? get longitude => _longitude;
  int? get loginType => _loginType;
  String? get deviceToken => _deviceToken;
  dynamic get blockedUsers => _blockedUsers;
  int? get wallet => _wallet;
  int? get totalCollected => _totalCollected;
  int? get totalStreams => _totalStreams;
  int? get deviceType => _deviceType;
  int? get isNotification => _isNotification;
  int? get isVerified => _isVerified;
  int? get showOnMap => _showOnMap;
  int? get anonymous => _anonymous;
  int? get isVideoCall => _isVideoCall;
  int? get canGoLive => _canGoLive;
  int? get isLiveNow => _isLiveNow;
  int? get isFake => _isFake;
  dynamic get password => _password;
  int? get following => _following;
  int? get followers => _followers;
  String? get createdAt => _createdAt;
  String? get updateAt => _updateAt;
  List<Stories>? get stories => _stories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['is_block'] = _isBlock;
    map['gender'] = _gender;
    map['savedprofile'] = _savedprofile;
    map['likedprofile'] = _likedprofile;
    map['interests'] = _interests;
    map['age'] = _age;
    map['identity'] = _identity;
    map['fullname'] = _fullname;
    map['instagram'] = _instagram;
    map['youtube'] = _youtube;
    map['facebook'] = _facebook;
    map['live'] = _live;
    map['bio'] = _bio;
    map['about'] = _about;
    map['lattitude'] = _lattitude;
    map['longitude'] = _longitude;
    map['login_type'] = _loginType;
    map['device_token'] = _deviceToken;
    map['blocked_users'] = _blockedUsers;
    map['wallet'] = _wallet;
    map['total_collected'] = _totalCollected;
    map['total_streams'] = _totalStreams;
    map['device_type'] = _deviceType;
    map['is_notification'] = _isNotification;
    map['is_verified'] = _isVerified;
    map['show_on_map'] = _showOnMap;
    map['anonymous'] = _anonymous;
    map['is_video_call'] = _isVideoCall;
    map['can_go_live'] = _canGoLive;
    map['is_live_now'] = _isLiveNow;
    map['is_fake'] = _isFake;
    map['password'] = _password;
    map['following'] = _following;
    map['followers'] = _followers;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    if (_stories != null) {
      map['stories'] = _stories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Stories {
  Stories({
    int? id,
    int? userId,
    int? type,
    int? duration,
    String? content,
    dynamic viewByUserIds,
    String? createdAt,
    String? updatedAt,
    bool? storyView,
  }) {
    _id = id;
    _userId = userId;
    _type = type;
    _duration = duration;
    _content = content;
    _viewByUserIds = viewByUserIds;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _storyView = storyView;
  }

  Stories.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _type = json['type'];
    _duration = json['duration'];
    _content = json['content'];
    _viewByUserIds = json['view_by_user_ids'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _storyView = json['storyView'];
  }
  int? _id;
  int? _userId;
  int? _type;
  int? _duration;
  String? _content;
  dynamic _viewByUserIds;
  String? _createdAt;
  String? _updatedAt;
  bool? _storyView;

  int? get id => _id;
  int? get userId => _userId;
  int? get type => _type;
  int? get duration => _duration;
  String? get content => _content;
  dynamic get viewByUserIds => _viewByUserIds;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  bool? get storyView => _storyView;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['duration'] = _duration;
    map['content'] = _content;
    map['view_by_user_ids'] = _viewByUserIds;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['storyView'] = _storyView;
    return map;
  }
}

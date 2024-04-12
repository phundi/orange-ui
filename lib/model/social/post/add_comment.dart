import 'package:orange_ui/model/social/feed.dart';
import 'package:orange_ui/model/user/registration_user.dart';

class AddComment {
  AddComment({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  AddComment.fromJson(dynamic json) {
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
    int? userId,
    int? postId,
    String? description,
    String? updatedAt,
    String? createdAt,
    int? id,
    Post? post,
  }) {
    _userId = userId;
    _postId = postId;
    _description = description;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
    _post = post;
  }

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _postId = json['post_id'];
    _description = json['description'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
    _post = json['post'] != null ? Post.fromJson(json['post']) : null;
  }
  int? _userId;
  int? _postId;
  String? _description;
  String? _updatedAt;
  String? _createdAt;
  int? _id;
  Post? _post;

  int? get userId => _userId;
  int? get postId => _postId;
  String? get description => _description;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;
  Post? get post => _post;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['post_id'] = _postId;
    map['description'] = _description;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    if (_post != null) {
      map['post'] = _post?.toJson();
    }
    return map;
  }
}

class Post {
  Post({
    int? id,
    int? userId,
    String? description,
    String? interestIds,
    int? commentsCount,
    int? likesCount,
    String? hashtags,
    String? createdAt,
    String? updatedAt,
    RegistrationUserData? user,
    List<Content>? content,
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
    _user = user;
    _content = content;
  }

  Post.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _description = json['description'];
    _interestIds = json['interest_ids'];
    _commentsCount = json['comments_count'];
    _likesCount = json['likes_count'];
    _hashtags = json['hashtags'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? RegistrationUserData.fromJson(json['user']) : null;
    if (json['content'] != null) {
      _content = [];
      json['content'].forEach((v) {
        _content?.add(Content.fromJson(v));
      });
    }
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
  RegistrationUserData? _user;
  List<Content>? _content;

  int? get id => _id;
  int? get userId => _userId;
  String? get description => _description;
  String? get interestIds => _interestIds;
  int? get commentsCount => _commentsCount;
  int? get likesCount => _likesCount;
  String? get hashtags => _hashtags;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  RegistrationUserData? get user => _user;
  List<Content>? get content => _content;

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
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_content != null) {
      map['content'] = _content?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

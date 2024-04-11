class AddPost {
  AddPost({
    bool? status,
    String? message,
    AddPostData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  AddPost.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? AddPostData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  AddPostData? _data;

  bool? get status => _status;
  String? get message => _message;
  AddPostData? get data => _data;

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

class AddPostData {
  AddPostData({
    int? id,
    int? userId,
    String? description,
    String? interestIds,
    int? commentsCount,
    int? likesCount,
    String? hashtags,
    String? createdAt,
    String? updatedAt,
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
    _content = content;
  }

  AddPostData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _description = json['description'];
    _interestIds = json['interest_ids'];
    _commentsCount = json['comments_count'];
    _likesCount = json['likes_count'];
    _hashtags = json['hashtags'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
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
    if (_content != null) {
      map['content'] = _content?.map((v) => v.toJson()).toList();
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

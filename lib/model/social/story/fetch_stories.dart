import 'package:orange_ui/model/social/feed.dart';

class FetchStories {
  FetchStories({
    bool? status,
    String? message,
    List<UsersStories>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchStories.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UsersStories.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<UsersStories>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<UsersStories>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

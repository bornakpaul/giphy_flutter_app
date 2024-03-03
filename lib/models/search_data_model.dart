// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SearchListModel extends Equatable {
  final List<SearchDataModel> data;
  const SearchListModel({
    required this.data,
  });

  SearchListModel copyWith({
    List<SearchDataModel>? data,
  }) {
    return SearchListModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory SearchListModel.fromMap(Map<String, dynamic> map) {
    return SearchListModel(
      data: List<SearchDataModel>.from(
        (map['data'] as List<dynamic>).map<SearchDataModel>(
          (x) => SearchDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchListModel.fromJson(String source) =>
      SearchListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [data];
}

class SearchDataModel extends Equatable {
  final String? title;
  final String type;
  final String? username;
  final String? gifUrl;
  const SearchDataModel({
    this.title,
    required this.type,
    this.username,
    required this.gifUrl,
  });

  SearchDataModel copyWith({
    String? title,
    String? type,
    String? username,
    String? gifUrl,
  }) {
    return SearchDataModel(
      title: title ?? this.title,
      type: type ?? this.type,
      username: username ?? this.username,
      gifUrl: gifUrl ?? this.gifUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'type': type,
      'username': username,
      'gifUrl': gifUrl,
    };
  }

  factory SearchDataModel.fromMap(Map<String, dynamic> map) {
    return SearchDataModel(
      title: map['title'] != null ? map['title'] as String : null,
      type: map['type'] as String,
      username: map['username'] != null ? map['username'] as String : null,
      gifUrl: map['images']['original']['url'] != null
          ? map['images']['original']['url'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchDataModel.fromJson(String source) =>
      SearchDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        title,
        type,
        username,
        gifUrl,
      ];
}

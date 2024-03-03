// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:giphy_demo_app/models/category_data_model.dart';

class CategoryListModel extends Equatable {
  final List<CategoryDataModel> data;
  const CategoryListModel({
    required this.data,
  });

  CategoryListModel copyWith({
    List<CategoryDataModel>? data,
  }) {
    return CategoryListModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryListModel.fromMap(Map<String, dynamic> map) {
    return CategoryListModel(
      data: List<CategoryDataModel>.from(
        (map['data'] as List<dynamic>).map<CategoryDataModel>(
          (x) => CategoryDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryListModel.fromJson(String source) =>
      CategoryListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [data];
}

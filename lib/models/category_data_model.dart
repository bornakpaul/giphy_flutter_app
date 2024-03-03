// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryDataModel extends Equatable {
  final String name;
  final List<SubCategoryData> subcategories;
  final String? gif;
  const CategoryDataModel({
    required this.name,
    required this.subcategories,
    required this.gif,
  });

  CategoryDataModel copyWith({
    String? name,
    List<SubCategoryData>? subcategories,
    String? gif,
  }) {
    return CategoryDataModel(
      name: name ?? this.name,
      subcategories: subcategories ?? this.subcategories,
      gif: gif ?? this.gif,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'subcategories': subcategories.map((x) => x.toMap()).toList(),
      'gif': gif,
    };
  }

  factory CategoryDataModel.fromMap(Map<String, dynamic> map) {
    return CategoryDataModel(
      name: map['name'] as String,
      subcategories: List<SubCategoryData>.from(
        (map['subcategories'] as List<dynamic>).map<SubCategoryData>(
          (x) => SubCategoryData.fromMap(x as Map<String, dynamic>),
        ),
      ),
      gif: map['gif']['images']['original']['url'] != null
          ? map['gif']['images']['original']['url'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryDataModel.fromJson(String source) =>
      CategoryDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        name,
        subcategories,
        gif,
      ];
}

class SubCategoryData extends Equatable {
  final String name;
  final String name_encoded;
  const SubCategoryData({
    required this.name,
    required this.name_encoded,
  });

  SubCategoryData copyWith({
    String? name,
    String? name_encoded,
  }) {
    return SubCategoryData(
      name: name ?? this.name,
      name_encoded: name_encoded ?? this.name_encoded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'name_encoded': name_encoded,
    };
  }

  factory SubCategoryData.fromMap(Map<String, dynamic> map) {
    return SubCategoryData(
      name: map['name'] as String,
      name_encoded: map['name_encoded'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategoryData.fromJson(String source) =>
      SubCategoryData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, name_encoded];
}

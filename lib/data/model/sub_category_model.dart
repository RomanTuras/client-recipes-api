import 'package:recipes/domain/entities/sub_category.dart';

class SubCategoryModel extends SubCategory {
  SubCategoryModel({
    required super.id,
    required super.name,
    required super.parentId,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parent_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parent_id': parentId,
    };
  }
}

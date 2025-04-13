
import 'package:recipes/domain/entities/category_content.dart';

class CategoryContentModel extends CategoryContent {
  CategoryContentModel({
    required super.subCategories,
    required super.recipes,
  });

  factory CategoryContentModel.fromJson(Map<String, dynamic> json) {
    return CategoryContentModel(
      subCategories: json['sub_categories'],
      recipes: json['recipes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub_categories': subCategories,
      'recipes': recipes,
    };
  }
}

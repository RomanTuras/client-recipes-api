
import 'package:recipes/domain/entities/category_content.dart';

class CategoryContentModel extends CategoryContent {
  CategoryContentModel({
    required super.subCategories,
    required super.recipes,
    required super.mainCategoryName,
  });

  factory CategoryContentModel.fromJson(Map<String, dynamic> json) {
    return CategoryContentModel(
      subCategories: json['sub_categories'],
      recipes: json['recipes'],
      mainCategoryName: json['main_category_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub_categories': subCategories,
      'recipes': recipes,
      'main_category_name': mainCategoryName,
    };
  }
}

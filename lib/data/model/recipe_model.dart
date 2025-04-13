
import 'package:recipes/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required super.id,
    required super.recipeTitle,
    required super.recipe,
    required super.categoryId,
    required super.make,
    required super.subCategoryId,
    required super.image,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      recipeTitle: json['recipe_title'],
      recipe: json['recipe'],
      categoryId: json['category_id'],
      make: json['make'],
      subCategoryId: json['sub_category_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipe_title': recipeTitle,
      'recipe': recipe,
      'category_id': categoryId,
      'make': make,
      'sub_category_id': subCategoryId,
      'image': image,
    };
  }
}
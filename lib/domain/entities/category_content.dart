import 'dart:core';

import 'package:recipes/domain/entities/recipe.dart';
import 'package:recipes/domain/entities/sub_category.dart';

class CategoryContent {
  final List<SubCategory> subCategories;
  final List<Recipe> recipes;
  final String mainCategoryName;

  CategoryContent({
    required this.subCategories,
    required this.recipes,
    required this.mainCategoryName,
  });
}
import 'dart:core';

import 'package:recipes/domain/entities/recipe.dart';
import 'package:recipes/domain/entities/sub_category.dart';

class CategoryContent {
  final List<SubCategory> subCategories;
  final List<Recipe> recipes;

  CategoryContent({
    required this.subCategories,
    required this.recipes,
  });
}
class Recipe {
  final int id;
  final String recipeTitle;
  final String? recipe;
  final int categoryId;
  final bool make;
  final int? subCategoryId;
  final String? image;

  Recipe({
    required this.id,
    required this.recipeTitle,
    required this.recipe,
    required this.categoryId,
    required this.make,
    required this.subCategoryId,
    required this.image,
  });
}

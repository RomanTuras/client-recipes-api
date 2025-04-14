import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:recipes/data/model/recipe_model.dart';
import 'package:recipes/data/model/recipe_model.dart';

import '../../../data/model/category_model.dart';
import '../../../domain/repositories/cook_book_repository.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';


class RecipeViewmodel extends ChangeNotifier {
  final CookBookRepository _cookBookRepository;
  late Command0 load;
  late Command1<void, String> search;
  final int _id;

  RecipeViewmodel({required CookBookRepository cookBookRepository, required int id})
      : _cookBookRepository = cookBookRepository, _id = id {
    load = Command0(_load)..execute();
  }

  final _log = Logger('RecipeViewmodel');

  RecipeModel _recipe = RecipeModel(
      id: 0,
      recipeTitle: "",
      recipe: "",
      categoryId: 0,
      make: false,
      subCategoryId: 0,
      image: ""
  );

  RecipeModel get recipe => _recipe;

  Future<Result> _load() async {
    try {
      final result = await _cookBookRepository.fetchRecipe(_id);
      switch (result) {
        case Ok<RecipeModel>():
          _recipe = result.value;
          _log.fine('Loaded the recipe');
        case Error():
          _log.warning('Failed to load the recipe');
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}

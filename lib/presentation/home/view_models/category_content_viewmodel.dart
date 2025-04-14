import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:recipes/domain/entities/recipe.dart';

import '../../../data/model/category_content_model.dart';
import '../../../domain/entities/sub_category.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';


class CategoryContentViewmodel extends ChangeNotifier {
  final CookBookRepository _categoryRepository;
  final int _id;
  late Command0 load;
  late Command1<void, String> search;

  CategoryContentViewmodel({required CookBookRepository categoryRepository, required int id})
      : _categoryRepository = categoryRepository, _id = id {
    load = Command0(_load)..execute();
  }

  final _log = Logger('CategoryContentViewmodel');

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  List<SubCategory> _subcategories = [];
  List<SubCategory> get subcategories => _subcategories;

  Future<Result> _load() async {
    try {
      final result = await _categoryRepository.fetchCategoryContent(_id);
      switch (result) {
        case Ok<CategoryContentModel>():
          _subcategories = result.value.subCategories;
          _recipes = result.value.recipes;
          _log.fine('Loaded category content');
        case Error<CategoryContentModel>():
          _log.warning('Failed to load category content');
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}

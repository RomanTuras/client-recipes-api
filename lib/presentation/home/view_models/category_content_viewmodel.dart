import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:recipes/domain/entities/recipe.dart';

import '../../../data/model/category_content_model.dart';
import '../../../domain/entities/sub_category.dart';
import '../../../domain/repositories/cook_book_repository.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';


class CategoryContentViewmodel extends ChangeNotifier {
  final CookBookRepository _cookBookRepository;
  final int _id;
  late Command0 load;
  late Command1<void, String> search;

  CategoryContentViewmodel({required CookBookRepository cookBookRepository, required int id})
      : _cookBookRepository = cookBookRepository, _id = id {
    load = Command0(_load)..execute();
  }

  final _log = Logger('CategoryContentViewmodel');

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  List<SubCategory> _subcategories = [];
  List<SubCategory> get subcategories => _subcategories;

  String _mainCategoryName = '';
  String get mainCategoryName => _mainCategoryName;

  Future<Result> _load() async {
    try {
      final result = await _cookBookRepository.fetchCategoryContent(_id);
      switch (result) {
        case Ok<CategoryContentModel>():
          _subcategories = result.value.subCategories;
          _recipes = result.value.recipes;
          _mainCategoryName = result.value.mainCategoryName;
          _log.fine('Loaded content of the category "$_mainCategoryName"');
        case Error<CategoryContentModel>():
          _log.warning('Failed to load category content');
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}

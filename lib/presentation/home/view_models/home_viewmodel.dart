import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/model/category_model.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';


class HomeViewmodel extends ChangeNotifier {
  final CookBookRepository _categoryRepository;
  late Command0 load;
  late Command1<void, String> search;

  HomeViewmodel({required CookBookRepository categoryRepository})
      : _categoryRepository = categoryRepository {
    load = Command0(_load)..execute();
  }

  final _log = Logger('HomeViewmodel');

  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  Future<Result> _load() async {
    try {
      final result = await _categoryRepository.fetchMainCategories();
      switch (result) {
        case Ok<List<CategoryModel>>():
          _categories = result.value;
          _log.fine('Loaded main categories');
        case Error():
          _log.warning('Failed to load main categories');
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}

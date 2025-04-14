
import 'package:logging/logging.dart';
import 'package:recipes/data/model/category_content_model.dart';
import 'package:recipes/data/model/recipe_model.dart';
import 'package:recipes/domain/repositories/cook_book_repository.dart';

import '../../../utils/result.dart';
import '../../model/category_model.dart';
import '../../services/cook_book_api_service.dart';

class CookBookRepositoryImpl implements CookBookRepository {
  CookBookRepositoryImpl({required CookBookApiService apiService})
      : _apiService = apiService;

  final CookBookApiService _apiService;

  final _log = Logger('CookBookRepositoryImpl');


  @override
  Future<Result<List<CategoryModel>>> fetchMainCategories() async {
    try {
      final result = await _apiService.fetchMainCategories();
      switch (result) {
        case Ok(value: final categories):
          return Result.ok(categories);
        case Error(error: final error):
          return Result.error(error);
      }
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }


  @override
  Future<Result<CategoryContentModel>> fetchCategoryContent(int id) async {
    try {
      final result = await _apiService.fetchCategoryContent(id);
      switch (result) {
        case Ok(value: final categories):
          return Result.ok(categories);
        case Error(error: final error):
          return Result.error(error);
      }
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<RecipeModel>> fetchRecipe(int id) async {
    try {
      final result = await _apiService.fetchRecipe(id);
      switch (result) {
        case Ok(value: final recipe):
          return Result.ok(recipe);
        case Error(error: final error):
          return Result.error(error);
      }
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

}

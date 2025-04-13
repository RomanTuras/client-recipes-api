
import 'package:recipes/data/model/category_content_model.dart';
import 'package:recipes/domain/repositories/category_repository.dart';

import '../../../utils/result.dart';
import '../../model/category_model.dart';
import '../../services/cook_book_api_service.dart';

class CookBookRepositoryImpl implements CookBookRepository {
  CookBookRepositoryImpl({required CookBookApiService apiService})
      : _apiService = apiService;

  final CookBookApiService _apiService;
  List<CategoryModel>? _cachedCategories;
  CategoryContentModel? _cachedCategoryContent;

  @override
  Future<Result<List<CategoryModel>>> fetchMainCategories() async {
    if (_cachedCategories == null) {
      final result = await _apiService.fetchMainCategories();
      if (result is Ok<List<CategoryModel>>) {
        _cachedCategories = result.value;
      }
      return result;
    } else {
      return Result.ok(_cachedCategories!);
    }
  }

  @override
  Future<Result<CategoryContentModel>> fetchCategoryContent(int categoryId) async {
    if (_cachedCategoryContent == null) {
      final result = await _apiService.fetchCategoryContent(categoryId);
      if (result is Ok<CategoryContentModel>) {
        _cachedCategoryContent = result.value;
      }
      return result;
    } else {
      return Result.ok(_cachedCategoryContent!);
    }
  }
}

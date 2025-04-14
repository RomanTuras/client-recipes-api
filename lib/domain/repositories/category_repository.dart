

import 'package:recipes/data/model/category_content_model.dart';

import '../../data/model/category_model.dart';
import '../../utils/result.dart';

abstract class CookBookRepository {
  /// Fetching the list of main categories [CategoryModel]
  Future<Result<List<CategoryModel>>> fetchMainCategories();

  /// Fetching the content of certain category by ID [CategoryContentModel]
  Future<Result<CategoryContentModel>> fetchCategoryContent(int id);
}

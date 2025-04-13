import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:recipes/data/model/recipe_model.dart';
import 'package:recipes/data/model/sub_category_model.dart';
import 'package:recipes/domain/entities/recipe.dart';
import 'package:recipes/utils/result.dart';

import '../../config/constants.dart';
import '../../domain/entities/sub_category.dart';
import '../model/category_content_model.dart';
import '../model/category_model.dart';

class CookBookApiService {
  final Map<String, String>? _headers;

  CookBookApiService({Map<String, String>? headers})
      : _headers = headers ??
      {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  final _log = Logger('CookBookApiService');

  Future<Result<List<CategoryModel>>> fetchMainCategories() async {
    try {
      final response = await http.get(
          Uri.parse(
              '$recipesAPIBaseURL/main-categories'),
          headers: _headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        _log.info('fetchCategories');
        return Result.ok(data.map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList());
      } else {
        return Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<CategoryContentModel>> fetchCategoryContent(categoryId) async {
    try {
      final response = await http.get(
          Uri.parse(
              '$recipesAPIBaseURL/category/$categoryId'),
          headers: _headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        List<SubCategoryModel> subcategories = (data['subcategories'] as List).map((json) => SubCategoryModel.fromJson(json)).toList();
        List<Recipe> recipes = (data['recipes'] as List).map((json) => RecipeModel.fromJson(json)).toList();
        final CategoryContentModel res = CategoryContentModel(subCategories: subcategories, recipes: recipes);
        return Result.ok(res);
      } else {
        return Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}

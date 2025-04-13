abstract final class Routes {
  static const home = '/';
  static const login = '/login';
  static String categoryContentById(int id) => '/category/$id';
  static String recipeById(int id) => '/recipes/$id';
  static String recipesByCategoryId(int categoryId) => '/recipes/category/$categoryId';
}

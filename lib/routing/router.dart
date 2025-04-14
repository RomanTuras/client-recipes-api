import 'package:go_router/go_router.dart';
import 'package:recipes/data/model/recipe_model.dart';
import 'package:recipes/presentation/home/view_models/category_content_viewmodel.dart';
import 'package:recipes/presentation/home/view_models/recipe_viewmodel.dart';
import 'package:recipes/presentation/home/widgets/category_content_screen.dart';
import 'package:recipes/presentation/home/widgets/recipe_screen.dart';
import '../data/repositories/auth/auth_repository.dart';
import '../presentation/home/view_models/home_viewmodel.dart';
import '../presentation/home/widgets/home_screen.dart';
import 'routes.dart';
import 'package:provider/provider.dart';


GoRouter goRouter = GoRouter(
  initialLocation: Routes.home,
  redirect: (context, state) async {
    final authRepo = context.read<AuthRepository>();
    final loggedIn = await authRepo.isAuthenticated;
    final loggingIn = state.matchedLocation == Routes.login;

    if (!loggedIn) return Routes.login;
    if (loggingIn) return Routes.home;

    return null;
  },
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = HomeViewmodel(
          cookBookRepository: context.read(),
        );
        return HomeScreen(viewmodel: viewModel);
      },
    ),
    GoRoute(
      path: '/category/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final viewModel = CategoryContentViewmodel(
          cookBookRepository: context.read(),
          id: id,
        );
        return CategoryContentScreen(viewmodel: viewModel);
      },
    ),
    GoRoute(
      path: '/recipe/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final viewModel = RecipeViewmodel(
          cookBookRepository: context.read(),
          id: id,
        );
        return RecipeScreen(viewmodel: viewModel);
      },
    ),
  ],
);

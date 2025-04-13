import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes/presentation/home/view_models/category_content_viewmodel.dart';
import 'package:recipes/presentation/home/widgets/category_content_screen.dart';
import '../data/repositories/auth/auth_repository.dart';
import '../presentation/home/view_models/home_viewmodel.dart';
import '../presentation/home/widgets/home_screen.dart';
import 'routes.dart';
import 'package:provider/provider.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  redirect: _redirect,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        path: Routes.home,
        builder: (context, state) {
          final viewModel = HomeViewmodel(
            categoryRepository: context.read(),
          );
          return HomeScreen(viewmodel: viewModel);
        }),
    GoRoute(
        path: '/category/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final viewModel = CategoryContentViewmodel(
            categoryRepository: context.read(),
            id: id,
          );
          return CategoryContentScreen(viewmodel: viewModel);
        }),
  ],
);

// From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // if the user is not logged in, they need to login
  final loggedIn = await context.read<AuthRepository>().isAuthenticated;
  final loggingIn = state.matchedLocation == Routes.login;
  if (!loggedIn) {
    return Routes.login;
  }

  // if the user is logged in but still on the login page, send them to
  // the home page
  if (loggingIn) {
    return Routes.home;
  }

  // no need to redirect at all
  return null;
}

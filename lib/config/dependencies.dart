import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:recipes/data/repositories/cook_book/cook_book_repository_impl.dart';
import 'package:recipes/routing/router.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../data/repositories/auth/auth_repository_dev.dart';
import '../data/services/cook_book_api_service.dart';
import '../domain/repositories/cook_book_repository.dart';


List<SingleChildWidget> get providersRemote {
  return [
    Provider(
      create: (context) => CookBookApiService(),
    ),
    Provider(
      create: (context) => CookBookRepositoryImpl(
        apiService: context.read(),
      ) as CookBookRepository,
    ),
    ChangeNotifierProvider.value(
      value: AuthRepositoryDev() as AuthRepository,
    ),
    Provider<GoRouter>(
      create: (context) {
        return goRouter;
      },
    ),
  ];
}

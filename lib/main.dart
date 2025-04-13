import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:recipes/presentation/home/widgets/home_screen.dart';
import 'package:recipes/routing/router.dart';

import 'config/dependencies.dart';

void main() {
  Logger.root.level = Level.ALL;
  runApp(MultiProvider(
    providers: providersRemote,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      routerConfig: router(context.read()),
    );
  }
}
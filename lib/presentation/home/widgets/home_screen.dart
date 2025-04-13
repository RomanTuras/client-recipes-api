import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../view_models/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewmodel});

  final HomeViewmodel viewmodel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _log = Logger('HomeScreen');

  void onTapHandler(BuildContext context, int id) {
    _log.info("on tap: $id");
    context.go('/category/$id');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: ListenableBuilder(
          listenable: widget.viewmodel,
          builder: (context, child) {
            if (widget.viewmodel.load.running) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (widget.viewmodel.load.error) {
              return Text('Failed!');
            }

            return child ?? Text('Null');
          },
          child: ListenableBuilder(
              listenable: widget.viewmodel,
              builder: (context, child) {
                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15.0),
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      final category = widget.viewmodel.categories[index];
                                  return category.subcategories.isNotEmpty ? ListTile(
                                    leading: category.subcategories.isNotEmpty ? Icon(Icons.folder_copy_outlined) : Icon(Icons.folder_outlined),
                                    title: Text('${category.name} (${category.recipesCount})'),
                                    subtitle: Text(category.subcategories),
                                    onTap: () => {onTapHandler(context, category.id)},
                                  ) : ListTile(
                                    leading: category.subcategories.isNotEmpty ? Icon(Icons.folder_copy_outlined) : Icon(Icons.folder_outlined),
                                    title: Text('${category.name} (${category.recipesCount})'),
                                    onTap: () => {onTapHandler(context, category.id)},
                                  );
                                },
                                childCount: widget.viewmodel.categories.length, // Number of items
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

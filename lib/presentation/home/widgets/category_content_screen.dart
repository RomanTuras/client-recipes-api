import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:recipes/presentation/home/view_models/category_content_viewmodel.dart';

class CategoryContentScreen extends StatefulWidget {
  const CategoryContentScreen({super.key, required this.viewmodel});

  final CategoryContentViewmodel viewmodel;

  @override
  State<CategoryContentScreen> createState() => _CategoryContentScreenState();
}

class _CategoryContentScreenState extends State<CategoryContentScreen> {
  final _log = Logger('CategoryContentScreen');

  void onTapCategoryHandler(BuildContext context, int id) {
    _log.info("on tap category: $id");
    // context.go('/subcategory/$id');
  }

  void onTapRecipeHandler(BuildContext context, int id) {
    _log.info("on tap recipe: $id");
    context.push('/recipe/$id');
  }
  
  void onBackButtonPressed(BuildContext context) {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: ListenableBuilder(listenable: widget.viewmodel, builder: (_, child) {
              return Text(widget.viewmodel.mainCategoryName);
            },),
            leading: IconButton(
              onPressed: () => {onBackButtonPressed(context)},
              icon: Icon(Icons.arrow_left),),),
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
                  builder: (builder, child) {
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
                                      final subcategories = widget.viewmodel.subcategories;
                                      return ListTile(
                                        leading: const Icon(Icons.folder_outlined),
                                        title: Text('${subcategories[index].name} (recipes)'),
                                        onTap: () => {onTapCategoryHandler(context, subcategories[index].id)},
                                      );
                                    },
                                    childCount: widget.viewmodel.subcategories.length, // Number of items
                                  ),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                      final recipes = widget.viewmodel.recipes;
                                      return ListTile(
                                        leading: const Icon(Icons.receipt),
                                        title: Text(recipes[index].recipeTitle),
                                        onTap: () => {onTapRecipeHandler(context, recipes[index].id)},
                                      );
                                    },
                                    childCount: widget.viewmodel.recipes.length, // Number of items
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
              ),
        ),
        ),
    );
  }
}

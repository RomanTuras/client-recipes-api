import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes/presentation/home/view_models/recipe_viewmodel.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key, required this.viewmodel});

  final RecipeViewmodel viewmodel;

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {

  void onBackButtonPressed(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe:"),
        leading: IconButton(
          onPressed: () => {onBackButtonPressed(context)},
          icon: Icon(Icons.arrow_left),
        ),
      ),
      body: SingleChildScrollView(
        child: ListenableBuilder(
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

            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 6.0, bottom: 36.0),
              child: Column(
                children: [
                  Text(
                    widget.viewmodel.recipe.recipeTitle,
                    style: TextStyle(fontSize: 22.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(widget.viewmodel.recipe.recipe??"Not filled yet...", style: TextStyle(fontSize: 18.0),),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

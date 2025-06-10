import 'package:flutter/material.dart';
import 'package:food_for_family/features/model/recipe.dart';
import 'package:food_for_family/features/presenter/listRecipeViewModel.dart';
import 'package:food_for_family/features/presenter/recipeList.dart';
import 'package:stacked/stacked.dart';

class ListRecipeScreen extends StatelessWidget {
  final List<Recipe> recipes;
  const ListRecipeScreen({super.key, required this.recipes});

  void x(String id) {
    print('hoi $id');
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListRecipeViewModel>.reactive(
        viewModelBuilder: () => ListRecipeViewModel(recipesList: recipes),
        builder: (context, model, child) {
          return RecipeList(onRecipeSelect: x);
        });
  }
}

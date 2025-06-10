import 'package:flutter/material.dart';
import 'package:food_for_family/features/model/recipe.dart';

class Recipedetail extends StatelessWidget {
  final Recipe currentRecipe;

  const Recipedetail({super.key, required this.currentRecipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text(currentRecipe.name),

      ],),
    );
  }
}

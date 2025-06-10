import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_for_family/features/model/recipe.dart';

import 'recipeListItem.dart';

class RecipeList extends StatefulWidget {
  final Function(String) onRecipeSelect;

  const RecipeList({Key? key, required this.onRecipeSelect}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  String _sortOption = 'Rating'; // Default sort option
  bool _isAscending = false; // Sort order

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Column(
      children: [
        // Sorting dropdown
        DropdownButton<String>(
          value: _sortOption,
          items:
              <String>['Rating', 'Name', 'Last Made'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _sortOption = newValue!;
              // Toggle sort direction if same option selected
              _isAscending = _sortOption == newValue ? !_isAscending : false;
            });
          },
        ),
        // Recipes List
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('recipes').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final recipes = snapshot.data!.docs;

              // Convert documents to Recipe objects
              List<Recipe> recipeList = recipes.map((recipeData) {
                return Recipe.fromMap(recipeData.id, recipeData.data() as Map<String, dynamic>);
              }).toList();

              // Sort recipes based on the selected option
              if (_sortOption == 'Rating') {
                recipeList.sort((a, b) {
                  final aRating = a.rating ?? 0;
                  final bRating = b.rating ?? 0;
                  return _isAscending
                      ? aRating.compareTo(bRating)
                      : bRating.compareTo(aRating); // Sort based on rating
                });
              } else if (_sortOption == 'Name') {
                recipeList.sort((a, b) {
                  return _isAscending
                      ? a.name.compareTo(b.name)
                      : b.name.compareTo(a.name); // Sort based on name
                });
              } else if (_sortOption == 'Last Made') {
                recipeList.sort((a, b) {
                  // Assume you have a `lastMadeDate` property in your Recipe model
                  return _isAscending
                      ? a.lastMadeDate!.compareTo(b.lastMadeDate!)
                      : b.lastMadeDate!.compareTo(a.lastMadeDate!);
                });
              }

              return ListView.builder(
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  final recipe = recipeList[index];

                  return RecipeListItem(recipe: recipe);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

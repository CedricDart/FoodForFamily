import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/images.dart';
import 'package:food_for_family/features/detail/addEdit/recipeName.dart';
import 'package:food_for_family/features/detail/addEdit/submitButton.dart';
import 'package:food_for_family/features/detail/compontent/imagePickerWidget.dart';
import 'package:food_for_family/features/detail/recipeViewModel.dart';
import 'package:stacked/stacked.dart';

class RecipeForm extends StatefulWidget {
  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecipeViewModel>.reactive(
        viewModelBuilder: () => RecipeViewModel(),
        builder: (context, viewmodel, child) {
          return Scaffold(
            body: Stack(
              children: [
            // Background gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.shade200,
                        Colors.teal.shade700,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Optional decorative overlay (like a pattern or image)
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.1, // Adjust opacity for subtle background
                    child: Image.asset(
                      AppImages.backgroundPattern,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            
            
            
                Container(
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        const SizedBox(height: 10),
                        ImagePickerWidget(onImagesSelected: viewmodel.onImageSelected),
                        SizedBox(height: 20),

                        RecipeNameInput(controller: viewmodel.nameController),
                        SizedBox(height: 20),

                        SubmitButton(onSubmit: () async {
                          // Add logic to add/update the recipe in Firestore
                          await viewmodel.submitRecipe();
                          viewmodel.clearFields();
                        },)

                      ],
                    ),
                  ),
                ),


                /*FeedbackForm(recipeId: _recipeId),
                FeedbackList(recipeId: _recipeId),*/

              ],
            ),
          );
        });
  }
}

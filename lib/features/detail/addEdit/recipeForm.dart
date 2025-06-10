import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/images.dart';
import 'package:food_for_family/features/detail/addEdit/recipeName.dart';
import 'package:food_for_family/features/detail/addEdit/submitButton.dart';
import 'package:food_for_family/features/detail/addEdit/tagInput.dart';
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
            
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 50), // Space from top
                        Center(
                          child: ImagePickerWidget(onImagesSelected: viewmodel.onImageSelected),
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          controller: viewmodel.nameController,
                          labelText: 'Recipe Name',
                          icon: Icons.restaurant_menu,
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          controller: viewmodel.descriptionController,
                          labelText: 'Description',
                          icon: Icons.description,
                          maxLines: 3,
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          controller: viewmodel.durationController,
                          labelText: 'Duration (e.g., 30 mins)',
                          icon: Icons.timer,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        TagInput(
                          controller: viewmodel.tagsController,
                          onTagsChanged: (tags) {
                            viewmodel.tags = tags;
                          },
                        ),
                        SizedBox(height: 30),
                        SubmitButton(
                          onSubmit: () async {
                          // Add logic to add/update the recipe in Firestore
                          await viewmodel.submitRecipe();
                          viewmodel.clearFields();
                        },)

                      ],
                    ),
                  ), // Space at the bottom
                ),
              ],
            ),
          );
        });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    IconData? icon,
    int? maxLines,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon != null ? Icon(icon, color: Colors.white70) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        labelStyle: TextStyle(color: Colors.white70),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
    );
  }
}

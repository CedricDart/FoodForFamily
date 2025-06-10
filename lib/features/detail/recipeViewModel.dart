import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_for_family/common/viewmodels/base_viewmodel.dart';
import 'package:food_for_family/features/model/recipe.dart';

class RecipeViewModel extends BaseViewModel {
  final TextEditingController nameController = TextEditingController();
  List<File> selectedImages = [];

  // Constructor
  RecipeViewModel();

  // Function to submit the recipe
  Future<void> submitRecipe() async {
    if (nameController.text.isEmpty) {
      // Handle empty fields (e.g., show an error message)
      return;
    }

    try {
      // Upload images to Firebase Storage and get the URLs
      List<String> photoUrls = [];
      for (var image in selectedImages) {
        String imageUrl = await uploadImageToFirebaseStorage(image);
        photoUrls.add(imageUrl);
      }

      // If no images were selected, use an empty list
      String? thumbnailUrl = photoUrls.isNotEmpty ? photoUrls[0] : null;

      // Create a new Recipe object with multiple images and optional thumbnail
      Recipe newRecipe = Recipe(
        id: '',
        name: nameController.text,
        photoUrls: photoUrls,  // Store the list of image URLs
        thumbnailUrl: thumbnailUrl,  // Use the first image as thumbnail, if available
        dateCreated: DateTime.now(),
      );

      // Add the recipe to Firestore
      DocumentReference docRef = await FirebaseFirestore.instance.collection('recipes').add(newRecipe.toMap());

      // Update the Recipe object with the generated ID
      newRecipe.id = docRef.id;

      // Optionally, update Firestore with the ID
      await FirebaseFirestore.instance.collection('recipes').doc(newRecipe.id).update({'id': newRecipe.id});

      // Clear the fields after submission
      clearFields();
    } catch (e) {
      // Handle errors (e.g., show an error message)
      print('Error adding recipe: $e');
    }
  }





  // Function to clear the text fields
  void clearFields() {
    nameController.clear();
    selectedImages = [];
  }

  void onImageSelected(image) {
    selectedImages = image;
    notifyListeners();
  }

  // Placeholder for image upload logic
  Future<String> uploadImageToFirebaseStorage(File? image) async {
    if (image == null) {
      throw Exception("No image selected");
    }

    try {
      // Create a reference to the Firebase Storage location
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('recipes/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file to Firebase Storage
      await imageRef.putFile(image);

      // Get the download URL
      String downloadUrl = await imageRef.getDownloadURL();

      return downloadUrl; // Return the download URL
    } catch (e) {
      print("Error uploading image: $e");
      throw e; // Rethrow the error
    }
  }
}

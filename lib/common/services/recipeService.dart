import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_for_family/common/services/base/base_service.dart';
import 'package:food_for_family/features/model/recipe.dart';

class RecipeService extends BaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference recipeCollection = FirebaseFirestore.instance.collection('recipes');

  // Add a list of random thumbnail images
  final List<String> randomThumbnails = [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
    // Add more image URLs as needed
  ];

  // CREATE: Add a new recipe
  Future<void> createRecipe(Recipe recipe) async {
    await recipeCollection.add({
      'name': recipe.name,
      'photoUrls': recipe.photoUrls, // List of image URLs
      'thumbnailUrl': recipe.thumbnailUrl, // Thumbnail URL
      'dateCreated': recipe.dateCreated,
    });
  }

  // UPDATE: Update an existing recipe
  Future<void> updateRecipe(String id, Recipe recipe) async {
    await recipeCollection.doc(id).update({
      'name': recipe.name,
      'photoUrls': recipe.photoUrls, // List of image URLs
      'thumbnailUrl': recipe.thumbnailUrl, // Thumbnail URL
      'dateCreated': recipe.dateCreated,
    });
  }

  // READ: Get a list of all recipes
  Future<List<Recipe>> listRecipes() async {
    try {
      final snapshot = await _firestore.collection('recipes').get();
      return snapshot.docs
          .map((doc) => Recipe.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Handle errors
      print('Error retrieving recipes: $e');
      return [];
    }
  }

  // DELETE: Remove a recipe
  Future<void> deleteRecipe(String recipeId) async {
    try {
      await _firestore.collection('recipes').doc(recipeId).delete();
    } catch (e) {
      // Handle errors
      print('Error deleting recipe: $e');
    }
  }

  // Upload a single image to Firebase Storage and return its URL
  Future<String> uploadImage(File image) async {
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference storageRef = FirebaseStorage.instance.ref().child('recipes/$fileName');
    UploadTask uploadTask = storageRef.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL(); // Return the download URL
  }

  // Upload multiple images and return their URLs
  Future<List<String>> uploadImages(List<File> images) async {
    List<String> downloadUrls = [];
    for (var image in images) {
      String url = await uploadImage(image); // Use the existing uploadImage method
      downloadUrls.add(url);
    }
    return downloadUrls;
  }
}

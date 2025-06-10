import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_for_family/common/constants/images.dart';

final random = Random();

// Sample data for generating recipes
final sampleNames = [
  'Spaghetti Bolognese',
  'Chicken Curry',
  'Vegetable Stir Fry',
  'Beef Tacos',
  'Salmon Teriyaki',
  'Quinoa Salad',
  'Pasta Carbonara',
  'Miso Soup',
  'Burger Deluxe',
  'Tomato Soup'
];

final sampleDescriptions = [
  'A delightful recipe with rich flavors.',
  'Perfect for a quick and tasty meal.',
  'Healthy and full of vibrant colors.',
  'An indulgent treat with an authentic taste.',
  'Easy to prepare, yet absolutely delicious.'
];

final sampleDurations = ['20', '30', '45', '60', '90']; // Durations in minutes
final sampleRatings = [3.5, 4.0, 4.5, 4.7, 5.0];

final sampleCategories = [
  'Vegan', 'Quick Meals', 'Desserts', 'Chicken', 'Beef', 'Healthy', 'Italian', 'Asian'
];

final sampleImageUrls = [
  "https://firebasestorage.googleapis.com/v0/b/foodforfamily-8a8e3.appspot.com/o/recipes%2F1730886387607.jpg?alt=media&token=cd2ec628-18ed-4dc9-9386-e1c93606a552"
];

// Fake User Interaction Data (for simulation)
final sampleUserInteractions = [
  {'viewedTime': 15, 'cookedTimes': 5, 'rating': 4.5},
  {'viewedTime': 5, 'cookedTimes': 2, 'rating': 4.0},
  {'viewedTime': 10, 'cookedTimes': 1, 'rating': 4.8}
];

Future<void> populateDatabaseWithFakeRecipes(int count) async {
  CollectionReference recipeCollection = FirebaseFirestore.instance.collection('recipes');

  for (int i = 0; i < count; i++) {
    // Generate random data for each recipe
    String name = sampleNames[random.nextInt(sampleNames.length)];
    String description = sampleDescriptions[random.nextInt(sampleDescriptions.length)];
    String duration = sampleDurations[random.nextInt(sampleDurations.length)];
    double rating = sampleRatings[random.nextInt(sampleRatings.length)];
    DateTime dateCreated = DateTime.now().subtract(Duration(days: random.nextInt(365)));
    String category = sampleCategories[random.nextInt(sampleCategories.length)];

    // Upload placeholder images and get URLs
    List<String> photoUrls = [];
    for (String imagePath in sampleImageUrls) {
      photoUrls.add(imagePath);
    }
    String? thumbnailUrl = photoUrls.isNotEmpty ? photoUrls[0] : null;

    // Create the recipe data (no user-specific interactions here)
    Map<String, dynamic> recipeData = {
      'name': name,
      'description': description,
      'category': category,
      'duration': duration,
      'photoUrls': photoUrls,
      'thumbnailUrl': thumbnailUrl,
      'dateCreated': dateCreated.toIso8601String(),
      'rating': rating,  // Average rating, to be calculated separately
      'timesMade': random.nextInt(20),  // This is a general number, not specific to users
    };

    // Add the recipe to Firestore and get the document reference
    DocumentReference recipeDoc = await recipeCollection.add(recipeData);

    // Simulate user interactions for this recipe
    // We'll generate some fake user interactions for this recipe
    for (int j = 0; j < 5; j++) { // Assuming 5 fake users
      var interaction = sampleUserInteractions[random.nextInt(sampleUserInteractions.length)];
      String userId = 'user$j';  // Fake user ID (in a real app, you'd use actual user IDs)
      num viewedTime = interaction['viewedTime']!;
      num cookedTimes = interaction['cookedTimes']!;
      num userRating = interaction['rating']!;

      // Create the user interaction document under the recipe's subcollection
      Map<String, dynamic> userInteractionData = {
        'viewedTime': viewedTime,
        'cookedTimes': cookedTimes,
        'userRating': userRating,
        'lastViewed': DateTime.now().subtract(Duration(days: random.nextInt(365))).toIso8601String(),
      };

      // Add user interaction to the subcollection 'userInteractions'
      await recipeDoc.collection('userInteractions').doc(userId).set(userInteractionData);
    }

    print('Recipe $name with user interactions has been added to the database!');
  }

  print('$count fake recipes have been added to the database!');
}


// Function to simulate uploading placeholder images to Firebase Storage
Future<String> uploadImageToFirebaseStorage(String imagePath) async {
  try {
    // Create a reference to the Firebase Storage location
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('recipes/${DateTime.now().millisecondsSinceEpoch}_${imagePath.split('/').last}');

    // Simulate uploading a placeholder image
    await imageRef.putFile(File(imagePath));

    // Get the download URL
    String downloadUrl = await imageRef.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print("Error uploading image: $e");
    throw e; // Rethrow the error
  }
}

void main() async {
  // Populate Firestore with 100 fake recipes
  await populateDatabaseWithFakeRecipes(100);
}

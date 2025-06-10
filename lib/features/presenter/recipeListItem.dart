import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_for_family/features/detail/view/recipeDetailScreen.dart';
import 'package:food_for_family/features/model/recipe.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeListItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecipeDetailScreen(recipe: recipe), // Pass the complete recipe object
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              // Display the thumbnail image
              CachedNetworkImage(
                imageUrl: recipe.thumbnailUrl ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.image_not_supported,
                  size: 80,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    if (recipe.lastMadeDate != null) // Only display if lastMadeDate is not null
                      Text(
                        'Last Made: ${DateFormat('yyyy-MM-dd').format(recipe.lastMadeDate!.toDate())}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    if (recipe.rating != null) // Only display if rating is not null
                      Row(
                        children: [
                          // Display star rating
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          // Add some space between the stars and the rating text
                          Text(
                            recipe.rating!.toStringAsFixed(1), // Show rating with one decimal place
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

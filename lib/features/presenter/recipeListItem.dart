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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the thumbnail image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: recipe.thumbnailUrl ?? '',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                    if (recipe.lastMadeDate != null) // Only display if lastMadeDate is not null
                      Text(
                        'Last Made: ${DateFormat('yyyy-MM-dd').format(recipe.lastMadeDate!.toDate())}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    if (recipe.rating != null) // Only display if rating is not null
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < recipe.rating!.floor() ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 18,
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(
                            recipe.rating!.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
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

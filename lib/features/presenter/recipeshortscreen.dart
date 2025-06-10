import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_for_family/features/model/recipe.dart';
import 'package:food_for_family/features/presenter/storyoverlayscreen.dart';

class RecipeShortsScreen extends StatefulWidget {
  final List<Recipe> recipes;

  const RecipeShortsScreen({super.key, required this.recipes});

  @override
  _RecipeShortsScreenState createState() => _RecipeShortsScreenState();
}

class _RecipeShortsScreenState extends State<RecipeShortsScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadImages();
    });
  }

  void _preloadImages() {
    if (_pageController.hasClients) {
      int currentIndex = _pageController.page?.round() ?? 0;

      // Preload the current recipe image
      _cacheImage(currentIndex);

      // Preload the previous recipe image if it exists
      if (currentIndex > 0) {
        _cacheImage(currentIndex - 1);
      }

      // Preload the next recipe image if it exists
      if (currentIndex < widget.recipes.length - 1) {
        _cacheImage(currentIndex + 1);
      }

      // Optionally preload an extra next recipe image if it exists
      if (currentIndex < widget.recipes.length - 2) {
        _cacheImage(currentIndex + 2);
      }
    }
  }

  void _cacheImage(int index) {
    precacheImage(
      CachedNetworkImageProvider(widget.recipes[index].thumbnailUrl ?? ''),
      context,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
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

            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: recipeList.length,
              onPageChanged: (index) {
                _preloadImages();
              },
              itemBuilder: (context, index) {
                var currentRecipe = recipeList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeStoryOverlay(recipe: currentRecipe),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: currentRecipe.thumbnailUrl ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.2),
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.9)
                              ],
                              stops: const [0, 0.6, 0.75, 1],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentRecipe.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 5),
                                Text(
                                  currentRecipe.rating?.toStringAsFixed(1) ?? 'N/A',
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}

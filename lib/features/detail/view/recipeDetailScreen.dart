import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_for_family/features/model/recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen>
    with SingleTickerProviderStateMixin {
  double rating = 0.0; // Track the selected rating
  bool isFeedbackFormVisible = false; // Track feedback form visibility
  late AnimationController _controller; // Animation controller
  late Animation<Offset> _offsetAnimation; // Offset for slide transition

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start off-screen (bottom)
      end: Offset(0, 0), // End at the center of the screen
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller
    super.dispose();
  }

  Future<void> _updateLastMadeDate(BuildContext context, {bool shouldUpdateRating = false}) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Get the current timestamp from Firestore
      final currentTimestamp = FieldValue.serverTimestamp();

      // Update the recipe's lastMadeDate and rating
      await firestore.collection('recipes').doc(widget.recipe.id).update(shouldUpdateRating
          ? {
              'ratings': FieldValue.arrayUnion([rating]), // Add the new rating to the ratings array
            }
          : {
              'lastMadeDate': currentTimestamp,
            });

      // Notify the user that the action was successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: shouldUpdateRating ? Text(' rating updated!') : Text('Last made date updated!'),
          duration: Duration(seconds: 2), // Set the duration for the SnackBar
        ),
      );

      // Wait for the SnackBar to disappear
      await Future.delayed(Duration(seconds: 2)); // Match this with the duration of the SnackBar

      // Show the feedback form
      setState(() {
        isFeedbackFormVisible = !shouldUpdateRating; // Show the feedback form
      });
      _controller.forward(); // Start the slide-in animation
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Thumbnail
            widget.recipe.thumbnailUrl != null && widget.recipe.thumbnailUrl!.isNotEmpty
                ? Image.network(
                    widget.recipe.thumbnailUrl!,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Center(child: Text('No Thumbnail Available')),
                  ),
            // Photo URLs
            if (widget.recipe.photoUrls != null && widget.recipe.photoUrls!.isNotEmpty)
              Column(
                children: widget.recipe.photoUrls!.map((url) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: url.isNotEmpty
                        ? Image.network(
                            url,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Center(child: Text('No Image Available')),
                          ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call the function to update the recipe's last made date and rating
          isFeedbackFormVisible ? _updateLastMadeDate(context, shouldUpdateRating: true) : _updateLastMadeDate(context);
        },
        child: const Icon(Icons.check),
        tooltip: 'Just Eaten',
      ),
      bottomSheet: SlideTransition(
        position: _offsetAnimation,
        child: Visibility(
          visible: isFeedbackFormVisible,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rate this Recipe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating; // Update the rating state
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

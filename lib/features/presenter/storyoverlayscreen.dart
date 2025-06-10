import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_for_family/features/detail/view/recipeDetailScreen.dart';
import 'package:food_for_family/features/model/recipe.dart';

class RecipeStoryOverlay extends StatefulWidget {
  final Recipe recipe;

  const RecipeStoryOverlay({super.key, required this.recipe});

  @override
  _RecipeStoryOverlayState createState() => _RecipeStoryOverlayState();
}

class _RecipeStoryOverlayState extends State<RecipeStoryOverlay> {
  late PageController _pageController;
  int _currentImageIndex = 0;
  Timer? _timer;
  double _progress = 0.0;
  bool _showHint = true;
  bool _isBottomSheetOpen = false; // Track bottom sheet state
  static const storyDuration = Duration(seconds: 5);
  final DraggableScrollableController _scrollController = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
    _hideHintAfterDelay();
  }

  void _hideHintAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showHint = false;
        });
      }
    });
  }

  void _startAutoPlay() {
    _progress = 0.0;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isBottomSheetOpen) { // Only update if bottom sheet is not open
        setState(() {
          _progress += 0.02;
          if (_progress >= 1.0) {
            _progress = 0.0;
            _nextImage();
          }
        });
      }
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
  }

  void _resumeAutoPlay() {
    if (_timer == null || !_timer!.isActive) {
      _startAutoPlay();
    }
  }

  void _nextImage() {
    if (_currentImageIndex < widget.recipe.photoUrls.length - 1) {
      _currentImageIndex++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _onTap() {
    _progress = 0.0;
    _nextImage();
  }

  void _openBottomSheet() {
    _scrollController.animateTo(
      _scrollController.size > 0.6 ? 0.0 : 0.8, // Toggle between open and close
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // Update the state of the bottom sheet
    setState(() {
      _isBottomSheetOpen = !_isBottomSheetOpen;
    });

    // Stop or resume the timer based on the state
    if (_isBottomSheetOpen) {
      _stopAutoPlay(); // Stop timer when sheet opens
    } else {
      _resumeAutoPlay(); // Resume timer when sheet closes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: _onTap,
            onLongPress: _stopAutoPlay,
            onLongPressUp: _resumeAutoPlay,
            onVerticalDragStart: (_) => _openBottomSheet(), // Open on swipe up
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.recipe.photoUrls.length,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                  _progress = 0.0;
                });
              },
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: widget.recipe.photoUrls[index],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.image_not_supported, size: 100)),
                );
              },
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              children: List.generate(widget.recipe.photoUrls.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: LinearProgressIndicator(
                      value: (index == _currentImageIndex) ? _progress : (index < _currentImageIndex ? 1.0 : 0.0),
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 3,
                    ),
                  ),
                );
              }),
            ),
          ),
          DraggableScrollableSheet(
            controller: _scrollController,
            initialChildSize: 0.0,
            minChildSize: 0.0,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 30,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.recipe.name,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Duur: ${widget.recipe.duration} minuten', // Voorbeeld voor duur
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Aantal keer gemaakt: ${widget.recipe.timesMade}', // Voorbeeld voor aantal keren gemaakt
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Beschrijving:',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.recipe.description ?? 'Geen beschrijving beschikbaar.',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigeren naar het detailscherm
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailScreen(recipe: widget.recipe),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Bekijk details',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          if (_showHint)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Swipe up for details',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

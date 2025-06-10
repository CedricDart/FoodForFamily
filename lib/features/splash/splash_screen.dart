import 'package:flutter/material.dart';
import 'package:food_for_family/common/utils/route_generator.dart';
import 'package:food_for_family/features/home/home_screen.dart';
import 'package:food_for_family/features/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final List<String> _words = ['Discover', 'Add', 'Taste', 'Savor', 'Enjoy', 'Relish'];
  String _displayText = '';
  late AnimationController _controller;
  int _currentWordIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Adjust duration for complete typing and correction
    );

    _controller.addListener(() {
      setState(() {
        int charCount = (_controller.value * _words[_currentWordIndex].length).round();
        _displayText = _words[_currentWordIndex].substring(0, charCount);
      });
    });

    // Start the typing and correcting loop
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Start correcting the text after displaying the current word
        Future.delayed(Duration(milliseconds: 75), () {
          _controller.reverse(); // Remove current word
          _controller.addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              // Move to the next word and restart typing
              _currentWordIndex = (_currentWordIndex + 1) % _words.length;
              _displayText = ''; // Reset displayed text
              _controller.forward(); // Restart typing animation
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        viewModelBuilder: () => SplashViewModel(),
        onViewModelReady: (viewmodel) async {
          await viewmodel.initialize(context);
          viewmodel.onSkip.listen((skip) {
            context.mounted
                ? Navigator.pushReplacementNamed(context, routeHome,
                    arguments: HomeScreenArguments(skip))
                : null;
          });
        },
        builder: (context, model, child) {
          return Scaffold(
            body: Stack(
              children: [
                // Background Image
                Image.asset(
                  'assets/background.jpg', // Your background image
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Cool Banner with Animated Typing Text
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _displayText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Delicious Recipes!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Loading Indicator
                Positioned(
                  bottom: 30,
                  left: MediaQuery.of(context).size.width / 2 - 20,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        });
  }
}

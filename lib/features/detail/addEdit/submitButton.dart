import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final Future<void> Function() onSubmit;

  const SubmitButton({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isSubmitting = false;
  bool _isSubmitted = false;

  Future<void> _handleSubmit() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate the submission process
      await widget.onSubmit();

      setState(() {
        _isSubmitted = true;
      });

      // Delay before resetting to normal state
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
        _isSubmitted = false;
      });
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });
      // Handle error (show a snackbar or error message)
      print('Error submitting: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: _isSubmitted
          ? _buildSuccessIndicator()
          : _buildSubmitButton(), // Switch between button and success animation
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: _isSubmitting ? null : _handleSubmit,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.teal], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Center(
          child: _isSubmitting
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.send, color: Colors.white), // Send icon
              SizedBox(width: 8),
              Text(
                'Submit Recipe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIndicator() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green, // Success color
        borderRadius: BorderRadius.circular(30), // Rounded corners
      ),
      child: Center(
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}

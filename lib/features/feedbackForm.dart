import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  final String recipeId;

  FeedbackForm({required this.recipeId});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _commentController = TextEditingController();
  int _rating = 0;

  void _addFeedback() async {
    if (widget.recipeId.isNotEmpty && _rating > 0 && _commentController.text.isNotEmpty) {
      await _firestore.collection('recipes').doc(widget.recipeId).collection('feedback').add({
        'userId': 'some_user_id', // Replace with actual user ID
        'rating': _rating,
        'comment': _commentController.text,
        'date': FieldValue.serverTimestamp(),
      });
      _commentController.clear();
      setState(() {
        _rating = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback Added Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Feedback Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.star, color: _rating >= 1 ? Colors.yellow : Colors.grey),
              onPressed: () => setState(() => _rating = 1),
            ),
            IconButton(
              icon: Icon(Icons.star, color: _rating >= 2 ? Colors.yellow : Colors.grey),
              onPressed: () => setState(() => _rating = 2),
            ),
            IconButton(
              icon: Icon(Icons.star, color: _rating >= 3 ? Colors.yellow : Colors.grey),
              onPressed: () => setState(() => _rating = 3),
            ),
            IconButton(
              icon: Icon(Icons.star, color: _rating >= 4 ? Colors.yellow : Colors.grey),
              onPressed: () => setState(() => _rating = 4),
            ),
            IconButton(
              icon: Icon(Icons.star, color: _rating >= 5 ? Colors.yellow : Colors.grey),
              onPressed: () => setState(() => _rating = 5),
            ),
          ],
        ),
        TextField(
          controller: _commentController,
          decoration: InputDecoration(
            labelText: 'Comment',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _addFeedback,
          child: Text('Submit Feedback'),
        ),
      ],
    );
  }
}

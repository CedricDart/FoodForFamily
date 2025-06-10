import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedbackList extends StatelessWidget {
  final String recipeId;

  FeedbackList({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('recipes').doc(recipeId).collection('feedback').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final feedbackDocs = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: feedbackDocs.length,
          itemBuilder: (context, index) {
            final feedback = feedbackDocs[index];
            return ListTile(
              title: Text('Rating: ${feedback['rating']}'),
              subtitle: Text(feedback['comment']),
              trailing: Text(feedback['date']?.toDate().toString() ?? 'No Date'),
            );
          },
        );
      },
    );
  }
}

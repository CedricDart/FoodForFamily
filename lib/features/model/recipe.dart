import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String id;
  String name;
  String? thumbnailUrl; // Nullable to allow creation without a thumbnail
  String? description;
  String? duration;
  String? timesMade;
  List<String> photoUrls; // Nullable to allow creation without images
  DateTime dateCreated;
  Timestamp? lastMadeDate; // Add lastMadeDate as Firebase Timestamp
  double? rating; // New property for rating

  Recipe(
      {required this.id,
      required this.name,
      this.thumbnailUrl,
      this.photoUrls = const [],
      required this.dateCreated,
      this.lastMadeDate, // Optional field for last made date
      this.duration = '30',
      this.timesMade = '5',
      this.description =
          'de beschrijving van het gerecht ... kan extra lang zijn ook natuurlijk dus lorum ipsum',
      this.rating});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'thumbnailUrl': thumbnailUrl,
      'photoUrls': photoUrls,
      'dateCreated': dateCreated.toIso8601String(),
      'lastMadeDate': lastMadeDate, // Include lastMadeDate
      'rating': rating
    };
  }

  factory Recipe.fromMap(String id, Map<String, dynamic> map) {
    return Recipe(
        id: id,
        name: map['name'],
        thumbnailUrl: map['thumbnailUrl'],
        photoUrls: map['photoUrls'] != null ? List<String>.from(map['photoUrls']) : [],
        dateCreated: DateTime.parse(map['dateCreated']),
        lastMadeDate: map['lastMadeDate'] != null ? map['lastMadeDate'] as Timestamp : null,
        // Parse lastMadeDate
        rating: double.tryParse(map['rating'].toString()));
  }
}

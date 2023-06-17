import 'package:cloud_firestore/cloud_firestore.dart';

class Position {
  final String id;
  final String title;

  Position({
    required this.id,
    required this.title,
  });

  factory Position.fromJson(DocumentSnapshot snapshot) {
    return Position(
      id: snapshot.id,
      title: snapshot['title'],
    );
  }
}

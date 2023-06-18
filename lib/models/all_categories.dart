import 'package:cloud_firestore/cloud_firestore.dart';

class AllCategories {
  final String id;
  final DocumentReference canID;
  final DocumentReference posID;
  final dynamic vote;

  AllCategories({
    required this.id,
    required this.canID,
    required this.posID,
    required this.vote,
  });

  factory AllCategories.fromJson(DocumentSnapshot snapshot) {
    return AllCategories(
      id: snapshot.id,
      canID: snapshot['can_id'],
      posID: snapshot['pos_id'],
      vote: snapshot['vote'],
    );
  }
}

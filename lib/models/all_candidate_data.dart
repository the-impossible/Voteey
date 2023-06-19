import 'package:cloud_firestore/cloud_firestore.dart';

class AllCandidates {
  final String id;
  final DocumentReference canID;
  final DocumentReference posID;
  dynamic votes;

  AllCandidates({
    required this.id,
    required this.canID,
    required this.posID,
    required this.votes,
  });

  factory AllCandidates.fromJson(DocumentSnapshot snapshot) {
    return AllCandidates(
      id: snapshot.id,
      canID: snapshot['can_id'],
      posID: snapshot['pos_id'],
      votes: snapshot['votes'],
    );
  }
}

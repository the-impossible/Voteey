import 'package:cloud_firestore/cloud_firestore.dart';

class AllCandidates {
  final String id;
  final DocumentReference canID;
  final DocumentReference posID;

  AllCandidates({
    required this.id,
    required this.canID,
    required this.posID,
  });

  factory AllCandidates.fromJson(DocumentSnapshot snapshot) {
    return AllCandidates(
      id: snapshot.id,
      canID: snapshot['can_id'],
      posID: snapshot['pos_id'],
    );
  }
}

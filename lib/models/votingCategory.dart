import 'package:cloud_firestore/cloud_firestore.dart';

class VotingCategory {
  final String id;
  final String posTitle;
  final dynamic candidateNo;

  VotingCategory({
    required this.id,
    required this.posTitle,
    required this.candidateNo,
  });

  factory VotingCategory.fromJson(DocumentSnapshot snapshot) {
    return VotingCategory(
      id: snapshot.id,
      posTitle: snapshot['posTitle'],
      candidateNo: snapshot['candidateNo'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ResultDetails {
  final String id;
  final String name;
  final String image;
  final dynamic votes;

  ResultDetails({
    required this.id,
    required this.name,
    required this.image,
    required this.votes,
  });

  factory ResultDetails.fromJson(DocumentSnapshot snapshot) {
    return ResultDetails(
      id: snapshot.id,
      name: snapshot['name'],
      image: snapshot['image'],
      votes: snapshot['votes'],
    );
  }
}

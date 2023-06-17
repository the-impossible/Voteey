import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateDetail {
  final String id;
  final String name;
  final String regNo;
  final String image;
  final String position;

  CandidateDetail({
    required this.id,
    required this.name,
    required this.regNo,
    required this.image,
    required this.position,
  });

  factory CandidateDetail.fromJson(DocumentSnapshot snapshot) {
    return CandidateDetail(
      id: snapshot.id,
      name: snapshot['name'],
      regNo: snapshot['regNo'],
      image: snapshot['image'],
      position: snapshot['position'],
    );
  }
}

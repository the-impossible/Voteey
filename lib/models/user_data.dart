import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String id;
  final String name;
  final String regNo;
  final String type;
  final DateTime? created;

  UserData({
    required this.id,
    required this.name,
    required this.regNo,
    required this.type,
    required this.created,
  });

  factory UserData.fromJson(DocumentSnapshot snapshot) {
    return UserData(
      id: snapshot.id,
      name: snapshot['name'],
      regNo: snapshot['regNo'],
      type: snapshot['type'],
      created: snapshot['created'] != null
          ? (snapshot['created'] as Timestamp).toDate()
          : null,
    );
  }
}

import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:voteey/models/all_candidate_data.dart';
import 'package:voteey/models/candidate_details.dart';
import 'package:voteey/models/position_data.dart';
import 'package:voteey/models/user_data.dart';

class DatabaseService extends GetxController {
  String? uid;
  DatabaseService({this.uid});

  UserData? userData;

  // collection reference
  var usersCollection = FirebaseFirestore.instance.collection("Users");
  var positionCollection = FirebaseFirestore.instance.collection("Positions");
  var candidatesCollection =
      FirebaseFirestore.instance.collection("Candidates");
  var filesCollection = FirebaseStorage.instance.ref();

  //Create user
  Future createStudentData(String name, String regNo, String type) async {
    await setImage(uid, 'Users');
    return await usersCollection.doc(uid).set(
      {
        'name': name,
        'regNo': regNo,
        'type': type,
        'created': FieldValue.serverTimestamp(),
      },
    );
  }

  //Determine userType
  Future<UserData?> getUser(String uid) async {
    // Query database to get user type
    final snapshot = await usersCollection.doc(uid).get();
    // Return user type as string
    if (snapshot.exists) {
      userData = UserData.fromJson(snapshot);
      return UserData.fromJson(snapshot);
    }
    return null;
  }

  Future<bool> updateImage(File? image, String uid) async {
    filesCollection.child(uid).putFile(image!);
    return true;
  }

  Future<bool> setImage(String? uid, String path) async {
    final ByteData byteData = await rootBundle.load("assets/user.png");
    final Uint8List imageData = byteData.buffer.asUint8List();
    filesCollection.child("$path/$uid").putData(imageData);
    return true;
  }

  Future<String?> getImage(String uid, String path) async {
    try {
      final url = await filesCollection.child("$path/$uid").getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }

  Stream<String?> getCurrentUserImage(String uid, String path) {
    try {
      return filesCollection.child("$path/$uid").getDownloadURL().asStream();
    } catch (e) {
      return Stream.value(null);
    }
  }

  Stream<List<UserData>> getAccounts(String type) {
    return usersCollection
        .where('type', isEqualTo: type)
        .orderBy('created', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => UserData.fromJson(doc)).toList(),
        );
  }

  Future<List<Position>> getPositions() async {
    List<Position> positions = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await positionCollection.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in snapshot.docs) {
      Position position = Position.fromJson(documentSnapshot);
      positions.add(position);
    }

    return positions;
  }

  //Check if the student account exists
  Future<bool> verifyStudent(String regNo) async {
    QuerySnapshot<Map<String, dynamic>> snaps =
        await usersCollection.where('regNo', isEqualTo: regNo).get();
    if (snaps.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  //Check if the student account exists
  Future<bool> hasApplied(String regNo) async {
    final snapshot =
        await usersCollection.where('regNo', isEqualTo: regNo).get();

    if (snapshot.docs.isNotEmpty) {
      String studentId = snapshot.docs[0].id;
      final snaps = await candidatesCollection
          .where('can_id', isEqualTo: usersCollection.doc(studentId))
          .get();
      if (snaps.docs.isNotEmpty) return true;
    }
    return false;
  }

  Future<bool> applyCandidate(String regNo, String posID) async {
    final snapshot =
        await usersCollection.where('regNo', isEqualTo: regNo).get();

    if (snapshot.docs.isNotEmpty) {
      String studentId = snapshot.docs[0].id;
      candidatesCollection.doc().set({
        'can_id': usersCollection.doc(studentId),
        'pos_id': positionCollection.doc(posID),
      });

      return true;
    }
    return false;
  }

  // Stream<List<AllCandidates>> getCandidates() {
  //   return candidatesCollection
  //       .orderBy('pos_id', descending: true)
  //       .snapshots()
  //       .map(
  //         (snapshot) =>
  //             snapshot.docs.map((doc) => AllCandidates.fromJson(doc)).toList(),
  //       );
  // }

  Future<CandidateDetail?> getCandidate(
      DocumentReference canID, DocumentReference posID) async {
    // Query database to get user
    final userSnapshot = await canID.get();
    // Query database to get position
    final positionSnapshot = await posID.get();

    if (userSnapshot.exists && positionSnapshot.exists) {
      // Query database to get image
      String? imageSnapshot = await getImage(userSnapshot.id, 'Users');

      final candidateDetail = CandidateDetail(
        id: userSnapshot.id,
        name: userSnapshot['name'],
        regNo: userSnapshot['regNo'],
        image: imageSnapshot!,
        position: positionSnapshot['title'],
      );
      return candidateDetail;
    }
    return null;
  }

  Stream<List<CandidateDetail>> getCandidates() {
    return candidatesCollection
        .orderBy('pos_id', descending: true)
        .snapshots()
        .asyncMap<List<CandidateDetail?>>((snapshot) async {
      final candidateDetails = <CandidateDetail?>[];

      for (final doc in snapshot.docs) {
        final candidate = await getCandidate(doc['can_id'], doc['pos_id']);
        candidateDetails.add(candidate);
      }

      return candidateDetails;
    }).map((list) => list.whereType<CandidateDetail>().toList());
  }
}

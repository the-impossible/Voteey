import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:voteey/models/all_candidate_data.dart';
import 'package:voteey/models/all_categories.dart';
import 'package:voteey/models/candidate_details.dart';
import 'package:voteey/models/position_data.dart';
import 'package:voteey/models/result_stats.dart';
import 'package:voteey/models/user_data.dart';
import 'package:voteey/models/votingCategory.dart';

class DatabaseService extends GetxController {
  String? uid;
  DatabaseService({this.uid});

  UserData? userData;

  // collection reference
  var usersCollection = FirebaseFirestore.instance.collection("Users");
  var positionCollection = FirebaseFirestore.instance.collection("Positions");
  var votesCollection = FirebaseFirestore.instance.collection("Votes");
  var statusCollection = FirebaseFirestore.instance.collection("Status");
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
        'last_updated': FieldValue.serverTimestamp(),
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

  Stream<UserData?> getUserProfile(String uid) {
    return usersCollection.doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserData.fromJson(snapshot);
      }
      return null;
    });
  }

  Future<bool> updateProfileTime(String uid) async {
    usersCollection.doc(uid).update({
      'last_updated': FieldValue.serverTimestamp(),
    });
    return true;
  }

  Future<bool> updateImage(File? image, String uid, String path) async {
    filesCollection.child("$path/$uid").putFile(image!);
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

  Future<List<AllCandidates>> getCand() async {
    List<AllCandidates> candidates = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await candidatesCollection.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in snapshot.docs) {
      AllCandidates candidate = AllCandidates.fromJson(documentSnapshot);
      candidates.add(candidate);
    }

    return candidates;
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
        'votes': 0,
      });

      return true;
    }
    return false;
  }

  //get the details of a particular candidate
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
    //get all candidate by position
    return candidatesCollection
        .orderBy('pos_id', descending: true)
        .snapshots()
        .asyncMap<List<CandidateDetail?>>((snapshot) async {
      // create an empty candidate details list
      final candidateDetails = <CandidateDetail?>[];
      //loop through the gotten candidates snapshot
      for (final doc in snapshot.docs) {
        //call a helper function to get a particular candidate
        final candidate = await getCandidate(doc['can_id'], doc['pos_id']);
        //add the result to the candidateDetails
        candidateDetails.add(candidate);
      }

      return candidateDetails;
    }).map((list) => list.whereType<CandidateDetail>().toList());
  }

  Stream<List<VotingCategory>> groupCategories() {
    // get all positions
    return positionCollection.snapshots().asyncMap(
      (snapshot) async {
        // create an empty categories list
        List<VotingCategory> categories = [];
        // loop through the positions
        for (var positionDoc in snapshot.docs) {
          //assign the position id to a variable
          String positionId = positionDoc.id;
          //query all the candidates for that position
          QuerySnapshot candidatesSnapshot = await candidatesCollection
              .where('pos_id', isEqualTo: positionCollection.doc(positionId))
              .get();
          //verify that the candidateSnapshot is not empty
          if (candidatesSnapshot.docs.isNotEmpty) {
            //assign the candidateDos to a variable
            List<DocumentSnapshot> candidateDocs = candidatesSnapshot.docs;
            //add the category to the created list above
            VotingCategory category = VotingCategory(
              id: positionId,
              posTitle: positionDoc['title'],
              candidateNo: candidateDocs.length,
            );
            categories.add(category);
          }
        }
        return categories;
      },
    );
  }

  Future<VotingCategory?> positionCategories(String posID) async {
    // get all the positions
    DocumentSnapshot<Map<String, dynamic>> positionSnapshot =
        await positionCollection.doc(posID).get();
    // check if the position exists
    if (positionSnapshot.exists) {
      // get all the candidates with the existing position
      QuerySnapshot<Map<String, dynamic>> candidateSnapshot =
          await candidatesCollection
              .where('pos_id', isEqualTo: positionCollection.doc(posID))
              .get();
      //if the gotten snapshot is not empty
      if (candidateSnapshot.docs.isNotEmpty) {
        // assign the docs to a variable
        List<DocumentSnapshot> candidateDocs = candidateSnapshot.docs;
        // return voting category model
        return VotingCategory(
          id: posID,
          posTitle: positionSnapshot['title'],
          candidateNo: candidateDocs.length,
        );
      }
    }
    return null;
  }

  Future<List<CandidateDetail?>?> allCandidateByPos(String posID) async {
    // Get the position
    DocumentSnapshot<Map<String, dynamic>> positionSnapshot =
        await positionCollection.doc(posID).get();
    // Check if the position exists
    if (positionSnapshot.exists) {
      // get all candidate with applying for the position
      QuerySnapshot<Map<String, dynamic>> candidateSnapshot =
          await candidatesCollection
              .where('pos_id', isEqualTo: positionCollection.doc(posID))
              .get();
      // create a list of the return type
      final candidateDetails = <CandidateDetail?>[];
      // loop through the docs containing all the candidate
      for (final doc in candidateSnapshot.docs) {
        // call the helper method so that it provide the details of a candidate
        final candidate = await getCandidate(doc['can_id'], doc['pos_id']);
        candidateDetails.add(candidate); //add to the candidate list
      }
      return candidateDetails; //return the candidate details
    }
    return null;
  }

  Future<bool> castVote(String uID, String posID, String canID) async {
    //get voting collection equal to pos_id and user_id
    final snapshot = await votesCollection
        .where('pos_id', isEqualTo: positionCollection.doc(posID))
        .where('user_id', isEqualTo: usersCollection.doc(uID))
        .get();

    // verify user has not voted for that position (snapshot)? hasVoted : vote
    if (snapshot.docs.isEmpty) {
      // cast user vote
      votesCollection.doc().set({
        'can_id': candidatesCollection.doc(canID),
        'pos_id': positionCollection.doc(posID),
        'user_id': usersCollection.doc(uID),
      });

      // update candidate vote
      final candidateSnapshot = await candidatesCollection
          .where('can_id', isEqualTo: usersCollection.doc(canID))
          .get();

      if (candidateSnapshot.docs.isNotEmpty) {
        final candidateDoc = candidateSnapshot.docs[0];
        int currentVotes = candidateDoc['votes'] ?? 0;
        await candidateDoc.reference.update({'votes': currentVotes + 1});
        return true;
      }
      return false;
    }
    return false;
  }

  Stream<List<CandidateDetail>> winningCategories() {
    // get all candidates
    return candidatesCollection.snapshots().asyncMap((snapshot) async {
      // assign the snapshot to a model for easy access
      final List<AllCandidates> allCandidates =
          snapshot.docs.map((doc) => AllCandidates.fromJson(doc)).toList();

      // group candidate by their position
      final Map<String, List<AllCandidates>> candidatesByPosition = {};

      allCandidates.forEach((candidate) {
        final String posID = candidate.posID.id;
        if (candidatesByPosition.containsKey(posID)) {
          candidatesByPosition[posID]!.add(candidate);
        } else {
          candidatesByPosition[posID] = [candidate];
        }
      });

      // decide the winner
      final List<CandidateDetail> winningCandidates = [];

      for (final candidatesList in candidatesByPosition.values) {
        int maxVotes = 0;

        List<CandidateDetail> maxVoteCandidates = [];

        for (final candidate in candidatesList) {
          int votes = candidate.votes;
          final userSnapshot = await candidate.canID.get();
          final posSnapshot = await candidate.posID.get();

          if (votes > maxVotes) {
            CandidateDetail detail = CandidateDetail(
              id: candidate.id,
              name: userSnapshot['name'],
              regNo: posSnapshot.id,
              image: 'no-image',
              position: posSnapshot['title'],
            );
            maxVotes = votes;
            maxVoteCandidates = [detail];
          } else if (votes == maxVotes) {
            CandidateDetail detail = CandidateDetail(
              id: candidate.id,
              name: 'TIE 🔀',
              regNo: posSnapshot.id,
              image: 'no-image',
              position: posSnapshot['title'],
            );
            maxVoteCandidates = [detail];
          }
        }

        winningCandidates.addAll(maxVoteCandidates);
      }

      return winningCandidates;
    });
  }

  Stream<List<ResultDetails>> resultStatistics(String posID) {
    return candidatesCollection
        .where('pos_id', isEqualTo: positionCollection.doc(posID))
        .orderBy('votes', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<ResultDetails> resultDetails = [];

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final userSnapshot = await data['can_id'].get();
        final imageSnapshot = await getImage(userSnapshot.id, 'Users');

        resultDetails.add(ResultDetails(
          id: doc.id,
          name: userSnapshot['name'],
          image: imageSnapshot!,
          votes: data['votes'],
        ));
      }
      return resultDetails;
    });
  }

  Future<bool> deleteCandidate(String canID) async {
    try {
      final QuerySnapshot snapshot = await candidatesCollection
          .where('can_id', isEqualTo: usersCollection.doc(canID))
          .get();

      final List<QueryDocumentSnapshot> documents = snapshot.docs;

      if (documents.isNotEmpty) {
        final DocumentReference documentRef = documents[0].reference;
        await documentRef.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> beginOrEndVoting(bool status) async {
    try {
      final QuerySnapshot snapshot = await statusCollection.get();

      final List<QueryDocumentSnapshot> documents = snapshot.docs;

      if (documents.isNotEmpty) {
        final DocumentReference documentRef = documents[0].reference;
        await documentRef.update({'start_voting': status});
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  //
}

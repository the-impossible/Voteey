import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:voteey/models/user_data.dart';

class DatabaseService extends GetxController {
  String? uid;
  DatabaseService({this.uid});

  UserData? userData;

  // collection reference
  var usersCollection = FirebaseFirestore.instance.collection("Users");
  var filesCollection = FirebaseStorage.instance.ref();

  //Create user
  Future createStudentData(String name, String regNo, String type) async {
    await setImage(uid);
    return await usersCollection.doc(uid).set(
      {
        'name': name,
        'regNo': regNo,
        'type': type,
      },
    );
  }

  //Determine userType
  Future<UserData?> getUser(String uid) async {
    // Query database to get user type
    final snapshot = await usersCollection.doc(uid).get();
    // Return user type as string
    if (snapshot.exists) {
      userData = UserData.fromJson(snapshot.data()!);
      return UserData.fromJson(snapshot.data()!);
    }
    return null;
  }

  Future<bool> updateImage(File? image, String uid) async {
    filesCollection.child(uid).putFile(image!);
    return true;
  }

  Future<bool> setImage(String? uid) async {
    final ByteData byteData = await rootBundle.load("assets/user.png");
    final Uint8List imageData = byteData.buffer.asUint8List();
    filesCollection.child(uid!).putData(imageData);
    return true;
  }

  Stream<String?> getImage(String uid) {
    try {
      return filesCollection.child(uid).getDownloadURL().asStream();
    } catch (e) {
      return Stream.value(null);
    }
  }
}

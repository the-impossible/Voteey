import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voteey/routes/routes.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.splash,
    getPages: getPages,
  ));
}



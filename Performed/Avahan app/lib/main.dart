import 'package:avahanapp/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAottMulaEkfchyxlqOrzLx9LlT2MKA0cY",
          authDomain: "avahan-26259.firebaseapp.com",
          projectId: "avahan-26259",
          storageBucket: "avahan-26259.appspot.com",
          messagingSenderId: "430204812315",
          appId: "1:430204812315:web:273d908daf85d812d60cbe"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "hello",
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: homeScreen());
  }
}

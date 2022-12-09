import 'package:firebase_core/firebase_core.dart';
import 'package:first_crud_operation/home.dart';
import 'package:first_crud_operation/problem/Home.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: 'AIzaSyBaS7UD_ZW2jTjs7Jz43Vpb-aEscwWU_7E',
      //     appId: '1:441377699260:web:f06ae0ce9d0f9d0f99a7b9',
      //     messagingSenderId: '441377699260',
      //     projectId: 'splash-banking')
          );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

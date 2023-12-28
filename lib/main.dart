import 'package:flutter/material.dart';
import 'package:mini_pro/home.dart';
import 'package:mini_pro/otp.dart';
import 'package:mini_pro/phone.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'phone',
      routes: {
        'phone': (context) => const MyPhone(),
        'otp': (context) => const MyOtp(),
        'home': (context) => const MyHome(),
      },
    ),
  );
}

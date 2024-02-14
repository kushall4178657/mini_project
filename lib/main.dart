import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_pro/logout.dart';
import 'package:mini_pro/otp.dart';
import 'package:mini_pro/pages/home.dart';
import 'package:mini_pro/phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mini_pro/profile_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  FlutterNativeSplash.remove();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}
// FlutterNativeSplash.remove();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isLogin = false;
  var auth = FirebaseAuth.instance;
  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  void initState() {
    super.initState();
    checkIfLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin ? const HomePage() : const MyPhone(),
      // initialRoute: 'phone',
      routes: {
        'phone': (context) => const MyPhone(),
        'otp': (context) => const MyOtp(),
        'home': (context) => const HomePage(),
        'profile': (context) => ProfileScreen(),
        'logout': (context) => MyHome(),
      },
    );
  }
}

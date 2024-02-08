import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              signOut();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

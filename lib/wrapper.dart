// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FutureBuilder(
//         // Replace with your authentication check logic
//         future: checkUserProfile(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // If profile exists, navigate to the home page.
//             return snapshot.data ? HomePage() : ProfileSetupPage();
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }

//   // Replace with your actual logic to check if the user profile exists
//   Future<bool> checkUserProfile() async {
//     User? user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       DocumentSnapshot<Map<String, dynamic>> profileSnapshot =
//           await FirebaseFirestore.instance
//               .collection('users')
//               .doc(user.uid)
//               .get();

//       return profileSnapshot.exists;
//     }

//     return false;
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: Center(
//         child: Text('Welcome to the Home Page!'),
//       ),
//     );
//   }
// }

// class ProfileSetupPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Setup Page'),
//       ),
//       body: Center(
//         child: Text('Welcome to the Profile Setup Page!'),
//       ),
//     );
//   }
// }

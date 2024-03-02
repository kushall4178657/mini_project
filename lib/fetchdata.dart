import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyWidget extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  var name = '';
  var email = '';
  MyWidget(User? currentUser);

  Future<Map<String, dynamic>> getUserData() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      final snapshot = await users.doc(user!.uid).get();
      final data = snapshot.data() as Map<String, dynamic>;
      return data;
    } catch (e) {
      throw Exception('Error fetching user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final userData = snapshot.data!;
          name = userData['name'];
          email = userData['email'];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              userData['image'] != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userData['image']),
                    )
                  : Container(), // Display profile photo if available
              SizedBox(height: 20),
              Text(
                'Name: ${userData['name']}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Mobile: ${userData['mobile']}',
                style: TextStyle(fontSize: 18),
              ),
              // You can display other user data here
            ],
          );
        }
      },
    );
  }
}

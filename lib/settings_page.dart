import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  void deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection('Users').doc(user!.uid).delete();
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Orders')
          .doc()
          .delete();
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Addresses')
          .doc()
          .delete();
      await user!.delete();
      print("User account deleted successfully.");
    } catch (e) {
      print("Failed to delete user account: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          backgroundColor: Colors.pink,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    side: BorderSide(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.delete_outline_sharp),
                ),
                title: Text('Delete Account'),
                onTap: () {
                  deleteAccount();
                  Get.offAllNamed('phone');
                },
                // trailing: Container(
                //   width: 30,
                //   height: 30,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(100),
                //   ),
                //   child: Icon(Icons.chevron_right_rounded),
                // ),
              ),
              // ListTile(
              //   leading: Container(
              //     width: 30,
              //     height: 30,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(100),
              //     ),
              //     child: Icon(Icons.language_rounded),
              //   ),
              //   title: Text('Change Language'),
              //   trailing: Container(
              //     width: 30,
              //     height: 30,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(100),
              //     ),
              //     child: Icon(Icons.chevron_right_rounded),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

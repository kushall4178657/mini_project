import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepositry extends GetxController {
  static UserRepositry get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  createUser(user) async {
    await _db.collection("Users").add(user).whenComplete(
          () => Get.snackbar("Succes", "You're Account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        );
    catchError(error, stackTrace) {
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }
}

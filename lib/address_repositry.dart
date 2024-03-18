import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pro/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      if (userId.isEmpty)
        throw 'Unable to find User information. Try again in few minutes.';

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map((documentSnapshot) =>
              AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      print('Error fetching user addresses: $e');
      throw 'Something went wrong';
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {}
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something wrong';
    }
  }
}

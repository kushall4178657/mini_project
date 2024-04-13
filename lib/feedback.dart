import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_pro/phone.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final mobileController = TextEditingController();

  final feedbackcontroller = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  // storeUserInfo() async {
  //   String url = await uploadImage(selectedImage!);
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   FirebaseFirestore.instance.collection('Users').doc(uid).set({
  //     'image': url,
  //     'name': nameController.text,
  //     'email': emailController.text,
  //     'mobile': MyPhone.phone_num,
  //   }).then((value) {
  //     nameController.clear();
  //     emailController.clear();
  //     Get.toNamed('home');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.pink,
          title: const Text(
            'Feedback',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'What\'s you\'re Feedback?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Stack(
                  children: [],
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            } else if (value.length < 10) {
                              return 'Full Name is too short!';
                            }
                            return null;
                          },
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                              focusColor: Colors.pink,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.account_circle),
                              label: const Text('Full Name'),
                              labelStyle: const TextStyle(color: Colors.black)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: mobileController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.length < 10) {
                              return 'Mobile number must be at least 10 digits';
                            }
                            return null;
                          },
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                            focusColor: Colors.pink,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.phone_outlined),
                            label: Text('Phone Number'),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: feedbackcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your feedback';
                            } else if (value.length < 10) {
                              return 'Feedback too short';
                            }
                            return null;
                          },
                          maxLines: 4,
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                              focusColor: Colors.pink,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: const Icon(Icons.rate_review_rounded),
                              label: const Text('Share your Feedback'),
                              labelStyle: const TextStyle(color: Colors.black)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              // storeUserInfo();
                              if (_formKey.currentState!.validate()) {
                                Future<DocumentReference<Map<String, dynamic>>>
                                    collreference = FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(user!.uid)
                                        .collection('Feedback')
                                        .add(
                                  {
                                    'name': nameController.text,
                                    'mobile': mobileController.text,
                                    'feedback': feedbackcontroller.text
                                  },
                                );
                                // collreference.set(
                                //   {
                                //     'name': nameController.text,
                                //     'mobile': MyPhone.phone_num,
                                //     'feedback': feedbackcontroller.text
                                //   },
                                // );
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Send Feedback',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

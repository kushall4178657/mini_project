import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pro/phone.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Set Profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const SizedBox(
                          width: 120,
                          height: 120,
                          child: Image(
                            image: AssetImage('assets/image3.png'),
                          )),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 20,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                              focusColor: Colors.pink,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
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
                          controller: emailController,
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                              focusColor: Colors.pink,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              prefixIcon: const Icon(Icons.email_outlined),
                              label: const Text('Email'),
                              labelStyle: const TextStyle(color: Colors.black)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: MyPhone.phone_num,
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                            focusColor: Colors.pink,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            prefixIcon: const Icon(Icons.phone_outlined),
                            // label: Text('Phone Number'),
                            // labelStyle: TextStyle(color: Colors.black),
                          ),
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
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () async {
                              DocumentReference<Map<String, dynamic>>
                                  collreference = FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(user!.uid);
                              collreference.set(
                                {
                                  'name': nameController.text,
                                  'email': emailController.text,
                                  'mobile': MyPhone.phone_num,
                                },
                              );
                              // SharedPreferences prefs =
                              //     await SharedPreferences.getInstance();
                              // prefs.setBool('profileSetup', true);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'home', ((route) => false));
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context, 'home', (route) => false);
                            },
                            child: const Text(
                              'Save',
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

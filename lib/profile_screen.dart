import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_pro/phone.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final mobileController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  final ImagePicker _picker = ImagePicker();

  File? selectedImage;

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  uploadImage(File image) async {
    String imageUrl = '';
    String fileName = image.path;
    var reference = FirebaseStorage.instance.ref().child('Users/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then(
      (value) {
        imageUrl = value;
        print('Download Url:$value');
      },
    );
    return imageUrl;
  }

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
                      child: selectedImage == null
                          ? Container(
                              decoration: BoxDecoration(color: Colors.grey),
                              width: 120,
                              height: 120,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 50.0,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              width: 120,
                              height: 120,
                              child: Image(
                                image: FileImage(selectedImage!),
                                fit: BoxFit.fill,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
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
                              // storeUserInfo();
                              String url = await uploadImage(selectedImage!);
                              DocumentReference<Map<String, dynamic>>
                                  collreference = FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(user!.uid);
                              collreference.set(
                                {
                                  'image': url,
                                  'name': nameController.text,
                                  'email': emailController.text,
                                  'mobile': MyPhone.phone_num,
                                },
                              );
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'home', ((route) => false));
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

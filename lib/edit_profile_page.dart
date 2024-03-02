import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_pro/phone.dart';
import 'package:mini_pro/fetchdata.dart';
import 'package:mini_pro/profile_screen.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final mobileController = TextEditingController();

  String profile_pic_url = '';

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

  // Method to fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(user!.uid)
                .get();

        if (snapshot.exists) {
          // Set initial values of form fields
          setState(() {
            nameController.text = snapshot.data()!['name'] ?? '';
            emailController.text = snapshot.data()!['email'] ?? '';
            mobileController.text = snapshot.data()!['mobile'] ?? '';
            profile_pic_url = snapshot.data()!['image'] ?? '';
          });
        }
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          centerTitle: true,
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white),
          ),
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: selectedImage == null && profile_pic_url.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(color: Colors.grey),
                              width: 120,
                              height: 120,
                              child: Image(
                                image: NetworkImage(profile_pic_url),
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              width: 120,
                              height: 120,
                              child: selectedImage != null
                                  ? Image(
                                      image: FileImage(selectedImage!),
                                      fit: BoxFit.fill,
                                    )
                                  : Icon(
                                      Icons.camera_alt_outlined,
                                      size: 50.0,
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
                          controller: mobileController,
                          enabled: false,
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                              focusColor: Colors.pink,
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              prefixIcon:
                                  const Icon(Icons.phone_android_rounded),
                              label: const Text('Mobile'),
                              labelStyle: const TextStyle(color: Colors.black)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
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
                                  'mobile': mobileController.text,
                                },
                              );
                            },
                            child: const Text(
                              'Update',
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

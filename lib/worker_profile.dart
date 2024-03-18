import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_pro/phone.dart';

class WorkerScreen extends StatefulWidget {
  WorkerScreen({super.key});

  @override
  State<WorkerScreen> createState() => _WorkerScreenState();
}

class _WorkerScreenState extends State<WorkerScreen> {
  List<String> items = [
    "Cleaner",
    "Cook",
    "Carpenter",
    "Plumber",
    "Electrician"
  ];
  String? _selectedVal = "Cleaner";
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final aboutController = TextEditingController();

  final mobileController = TextEditingController();

  final jobcontroller = TextEditingController();

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
    var reference = FirebaseStorage.instance.ref().child('Workers/$fileName');
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
                          // initialValue: MyPhone.phone_num,
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
                        SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField<String>(
                          //controller: jobcontroller,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Icon(Icons.cases_outlined),
                          ),
                          value: _selectedVal,
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(fontSize: 18),
                                  )))
                              .toList(),
                          onChanged: (item) => setState(
                            () => _selectedVal = item,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: aboutController,
                          maxLines: 4,
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                              focusColor: Colors.pink,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon:
                                  const Icon(Icons.border_color_outlined),
                              label: const Text('About'),
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
                              if (_formKey.currentState!.validate()) {
                                String url = await uploadImage(selectedImage!);
                                DocumentReference<Map<String, dynamic>>
                                    collreference = FirebaseFirestore.instance
                                        .collection('Workers')
                                        .doc(user!.uid);
                                collreference.set(
                                  {
                                    'image': url,
                                    'name': nameController.text,
                                    'mobile': mobileController.text,
                                    'jobtype': _selectedVal,
                                    'about': aboutController.text,
                                  },
                                );
                                // Navigator.pushNamedAndRemoveUntil(
                                //     context, 'home', ((route) => false));
                              }
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

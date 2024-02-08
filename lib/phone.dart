import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

class MyPhone extends StatefulWidget {
  const MyPhone({super.key});

  static String verify = "";
  static String phone_num = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var phone_no = "";
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenHeight(context, dividedBy: 2),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: const Image(
                    fit: BoxFit.fill,
                    width: double.infinity,
                    image: AssetImage('assets/image3.png'),
                  ),
                ),
                Container(
                  height: screenHeight(context, dividedBy: 2),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'HouseFix',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Register to get Started',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height: 75,
                          child: Row(
                            children: [
                              Expanded(
                                child: IntlPhoneField(
                                  controller: phoneController,
                                  cursorColor: Colors.pink,
                                  keyboardType: TextInputType.phone,
                                  dropdownTextStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    // focusColor: Colors.green,
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.pink,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.pink,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.pink,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.pink,
                                      ),
                                    ),
                                    hintText: "Enter Mobile Number",
                                  ),
                                  initialCountryCode: "IN",
                                  onChanged: (phone) {
                                    phone_no = phone.countryCode + phone.number;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (phone_no.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'Phone Number cannot be empty!',
                                  snackPosition: SnackPosition.BOTTOM,
                                  icon: const Icon(
                                    Icons.error_outline_sharp,
                                    color: Colors.red,
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                );
                              }
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: phone_no,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) async {
                                  await auth.signInWithCredential(credential);
                                },
                                verificationFailed: (FirebaseAuthException e) {
                                  if (e.code == 'invalid-phone-number') {
                                    Get.snackbar(
                                      'Error',
                                      'Phone Number is Invalid!',
                                      snackPosition: SnackPosition.BOTTOM,
                                      icon: const Icon(
                                        Icons.error_outline_sharp,
                                        color: Colors.red,
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                    );
                                  }
                                },
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  MyPhone.verify = verificationId;
                                  MyPhone.phone_num = phone_no;
                                  Navigator.pushNamed(context, "otp");
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Get Verification Code',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

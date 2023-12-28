import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  var phone_no = "";
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
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.black,
                        // offset: const Offset(
                        //   5.0,
                        //   5.0,
                        // ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Image(
                    width: double.infinity,
                    image: AssetImage('assets/image2.png'),
                  ),
                ),
                SafeArea(
                  child: Container(
                    height: screenHeight(context, dividedBy: 2),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'MaidMatch',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register to get Started',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
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
                                    cursorColor: Colors.green,
                                    keyboardType: TextInputType.phone,
                                    dropdownTextStyle: TextStyle(
                                      fontSize: 16,
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    focusNode: FocusNode(),
                                    decoration: InputDecoration(
                                      // focusColor: Colors.green,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.green,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.green,
                                        ),
                                      ),
                                      hintText: "Enter Mobile Number",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.green),
                                      ),
                                    ),
                                    initialCountryCode: "IN",
                                    onChanged: (phone) {
                                      phone_no =
                                          phone.countryCode + phone.number;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: phone_no,
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  verificationFailed:
                                      (FirebaseAuthException e) {},
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    MyPhone.verify = verificationId;
                                    MyPhone.phone_num += phone_no;
                                    Navigator.pushNamed(context, "otp");
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                );
                              },
                              child: Text(
                                'Get Verification Code',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pro/add_address.dart';
import 'package:mini_pro/address_controller.dart';
import 'package:mini_pro/address_model.dart';
import 'package:mini_pro/address_repositry.dart';
import 'package:mini_pro/carpenter_page.dart';
import 'package:mini_pro/cook_page.dart';
import 'package:mini_pro/electrician_page.dart';
import 'package:mini_pro/order_summary.dart';
import 'package:mini_pro/ordersuccess.dart';
import 'package:mini_pro/pages/cleaning.dart';
import 'package:mini_pro/pages/date_time.dart';
import 'package:mini_pro/painter_page.dart';
import 'package:mini_pro/plumber_page.dart';

class PaymentMethodsPage extends StatefulWidget {
  static String payment_option = '';
  static String order_status = 'In-process';
  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
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
            'Payment Methods',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.pink)),
                child: ListTile(
                  title: const Text(
                    'Credit Card',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  // leading: Image.asset(
                  //   'lib/icons/credit-card.png',
                  //   height: 40,
                  // ),
                  leading: Icon(
                    Icons.credit_card,
                    size: 40.0,
                  ),
                  // trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.snackbar(
                      'Coming Soon',
                      'This payment option is coming soon',
                      margin: EdgeInsets.all(10),
                      snackPosition: SnackPosition.BOTTOM,
                      icon: Icon(Icons.notification_important),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.pink)),
                child: ListTile(
                  title: const Text(
                    'Debit card',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  // leading: Image.asset(
                  //   'lib/icons/debit-card.png',
                  //   height: 40,
                  // ),
                  leading: Icon(
                    Icons.credit_card_rounded,
                    size: 40.0,
                  ),
                  // trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.snackbar(
                      'Coming Soon',
                      'This payment option is coming soon',
                      margin: EdgeInsets.all(10),
                      snackPosition: SnackPosition.BOTTOM,
                      icon: Icon(Icons.notification_important),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.pink)),
                child: ListTile(
                  title: const Text(
                    'UPI',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  leading: Image.asset(
                    'assets/upi.png',
                    height: 40,
                    width: 40,
                  ),
                  // leading: Icon(
                  //   Icons.abc,
                  //   size: 40.0,
                  // ),
                  // trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.snackbar(
                      'Coming Soon',
                      'This payment option is coming soon',
                      margin: EdgeInsets.all(10),
                      snackPosition: SnackPosition.BOTTOM,
                      icon: Icon(Icons.notification_important),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.pink,
                )),
                child: ListTile(
                  title: const Text(
                    'Cash on Delivery',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  leading: Image.asset(
                    'assets/banking.png',
                    height: 40,
                  ),
                  // trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    PaymentMethodsPage.payment_option = 'Cash On Delivery';
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('Orders')
                        .add({
                      'payment': PaymentMethodsPage.payment_option,
                      'Cleaning Service': '${CleaningPage.json}',
                      'Cooking Service': '${CookPage.serviceJson}',
                      'Painting Service':
                          '${PainterPage.finalService.name}--${PainterPage.finalService.description}',
                      'Plumbing Service':
                          '${PlumberPage.final_service.name}-${PlumberPage.final_service.description}',
                      'Electrician Service':
                          '${ElectricianPage.final_service.name}-${ElectricianPage.final_service.description}',
                      'Carpenter Service':
                          '${CarpenterPage.final_service.name}-${CarpenterPage.final_service.description}',
                      'datetime':
                          '${DateAndTime.final_date.date.day}-${DateAndTime.final_date.date.month}-${DateAndTime.final_date.date.year} ${DateAndTime.final_date.time}',
                      'extraservice': '${DateAndTime.final_date.extraServices}',
                      'servicetype': '${DateAndTime.final_date.repeat}',
                      'Address': '${AddAddress.final_address}',
                      'name': '${AddAddress.final_name}',
                      'phone number': '${AddAddress.phone_no}',
                      'totalVistingcharge': '${OrderSummary.total_price}',
                      'orderstatus': '${PaymentMethodsPage.order_status}'
                    }).then((_) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          CookPage.resetFinalService();
                          PainterPage.resetFinalService();
                          PlumberPage.resetFinalService();
                          CleaningPage.resetFinalService();
                          ElectricianPage.resetFinalService();
                          CarpenterPage.resetFinalService();
                          DateAndTime.extraprice = 0;
                          return OrderSuccessDialog();
                        },
                      );
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
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
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
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
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
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
                  // leading: Image.asset(
                  //   'lib/icons/upi.png',
                  //   height: 40,
                  // ),
                  leading: Icon(
                    Icons.abc,
                    size: 40.0,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
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
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Proceed to Payment',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

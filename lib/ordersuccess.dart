import 'package:flutter/material.dart';

class OrderSuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        Icons.check_circle,
        size: 60,
        color: Colors.green,
      ),
      title: Text('Order Placed Successfully'),
      content: Text('Your order has been placed successfully.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            Navigator.pushNamedAndRemoveUntil(context, 'bottombar',
                (route) => false); // Pop the PaymentMethodsPage
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

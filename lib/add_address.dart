import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pro/TSingleAddress.dart';
import 'package:mini_pro/add_new_address.dart';
import 'package:mini_pro/address_controller.dart';
import 'package:mini_pro/paymentmethod.dart';

class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddNewAddress());
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.purpleAccent,
        ),
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Select Address',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.pink,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Obx(
                  () => FutureBuilder(
                    key: Key(controller.refreshData.value.toString()),
                    future: controller.allUserAddresses(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child:
                                CircularProgressIndicator()); // Display loading indicator while data is being fetched
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      final addresses = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: addresses.length,
                        itemBuilder: (context, index) => TSingleAddress(
                          address: addresses[index],
                          onTap: () => controller.selectedAddress(
                            addresses[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => PaymentMethodsPage());
                  },
                  child: Text(
                    "Proceed To Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
